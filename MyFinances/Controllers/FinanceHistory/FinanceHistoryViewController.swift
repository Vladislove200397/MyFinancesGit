//
//  FinanceHistoryViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import UIKit

class FinanceHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    private var financeModel = RealmFinanceType()
    private var financeHistoryType: ChangeFinanceControllerType?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        registerCell()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setBackgroundGradient()
    }

    func set(financeModel: RealmFinanceType) {
        self.financeModel = financeModel
    }
    
    private func registerCell() {
        let nib = UINib(nibName: FinanceHistoryCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FinanceHistoryCell.id)
    }
    
    private func setBackgroundGradient() {
        let topColor = UIColor(hue: 0.12, saturation: 0.54, brightness: 0.20, alpha: 1.0).cgColor // #5e5e5e
        self.view.setGradientBackground(topColor: topColor, bottomColor: UIColor.black.cgColor)
    }
    
    
    @IBAction func didTapHistoryTypeButton(_ sender: UIButton) {
        switch sender.tag {
            case 3001:
                self.financeHistoryType = .plusValue
                tableView.reloadData()
            case 3002:
                self.financeHistoryType = .minusValue
                tableView.reloadData()
            default: break
        }
    }
    
    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
}


extension FinanceHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch financeHistoryType {
            case .plusValue:
                return financeModel.plusValues.count
            case .minusValue:
                return financeModel.minusValues.count
            case .none:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FinanceHistoryCell.id, for: indexPath)
        guard let financeHistoryType else { return cell}
        switch financeHistoryType {
            case .plusValue:
                (cell as? FinanceHistoryCell)?.plusSet(sumOperation: financeModel.plusValues[indexPath.row])
            case .minusValue:
                (cell as? FinanceHistoryCell)?.minusSet(sumOperation: financeModel.minusValues[indexPath.row])
        }
        return cell
    }
}

