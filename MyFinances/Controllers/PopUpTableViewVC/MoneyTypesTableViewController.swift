//
//  MoneyTypesTableViewController.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 3.02.23.
//

import UIKit

class MoneyTypesTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private weak var changeFinanceDelegate: SetRealmDataDelegate?
    private var readRealm = RealmManager<RealmFinanceType>().read()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
     
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self .preferredContentSize = CGSize (width: 200, height: tableView.contentSize.height)
        self.tableView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.tableView.backgroundView = blurEffectView
    }
    
    func set(changeControllerDelegate: SetRealmDataDelegate) {
        self.changeFinanceDelegate = changeControllerDelegate
    }
   
    private func registerCell() {
        let nib = UINib(nibName: MoneyTypeCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MoneyTypeCell.id)
    }
}

extension MoneyTypesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoneyTypeCell.id, for: indexPath)
        (cell as? MoneyTypeCell)?.set(realmFinances: readRealm[indexPath.row])
        
        return cell
    }
}

extension MoneyTypesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MoneyTypeCell else { return }
        
        changeFinanceDelegate?.setData(data: cell.financeModel)
        dismiss(animated: true)
    }
}
