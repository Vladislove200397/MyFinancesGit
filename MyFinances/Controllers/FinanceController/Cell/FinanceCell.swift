//
//  FinanceCell.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import UIKit

class FinanceCell: UITableViewCell {
    static let id = String(describing: FinanceCell.self)
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellMoneyType: UILabel!
    @IBOutlet weak var cellMoneyCount: UILabel!
    
    private(set) public var financeModel = RealmFinanceType()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(financeModel: RealmFinanceType) {
        let image = UIImage(data: financeModel.image)
        
        cellImageView.image = image?.withRenderingMode(.alwaysTemplate)
        cellMoneyType.text = "\(financeModel.type) \(financeModel.name)"
        cellMoneyCount.text = "\(financeModel.value)"
    }
}
