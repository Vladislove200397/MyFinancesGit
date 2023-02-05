//
//  FinanceViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import UIKit
import RealmSwift

class FinanceViewController: UIViewController {
    @IBOutlet weak var initialContentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var tabBarDataSource = TabItem.allCases
    var realmRead = RealmManager<RealmFinanceType>().read() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        registerCell()
        initialContentView.alpha = 0
        checkFinances()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.realmRead = RealmManager<RealmFinanceType>().read()
        self.tableView.reloadData()
        checkFinances()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setGradient()
    }
    
    private func checkFinances() {
        if realmRead.count == 0 {
            self.tableView.alpha = 0
            initialContentView.alpha = 1
        } else {
            self.tableView.alpha = 1
            initialContentView.alpha = 0
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: FinanceCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FinanceCell.id)
    }

    private func setGradient() {
        let topColor = UIColor(hue: 0.85, saturation: 0.46, brightness: 0.19, alpha: 1.0).cgColor // #301a2e
        self.view.setGradientBackground(topColor: topColor, bottomColor: UIColor.black.cgColor)
    }
    
    @IBAction func addFinanceButtonDidTap(_ sender: Any) {
        let addFinanceVc = AddFinanceViewController(nibName: String(describing: AddFinanceViewController.self), bundle: nil)
        addFinanceVc.updateBlock = {
            self.realmRead = RealmManager<RealmFinanceType>().read()
            self.tableView.reloadData()
            self.checkFinances()
        }
        present(addFinanceVc, animated: true)
    }
}

extension FinanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realmRead.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FinanceCell.id, for: indexPath)
        
        (cell as? FinanceCell)?.set(financeModel: realmRead[indexPath.row])
        return cell
    }
}
    
extension FinanceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let historyVC = FinanceHistoryViewController(nibName: String(describing: FinanceHistoryViewController.self), bundle: nil)
        historyVC.set(financeModel: realmRead[selectedIndex])

        self.definesPresentationContext = true
        historyVC.modalPresentationStyle = .overCurrentContext
        self.present(historyVC, animated: true, completion: nil)
    }
}
