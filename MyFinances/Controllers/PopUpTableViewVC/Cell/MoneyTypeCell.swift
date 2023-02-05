//
//  MoneyTypeCell.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 3.02.23.
//

import UIKit

class MoneyTypeCell: UITableViewCell {
    static let id = String(describing: MoneyTypeCell.self)
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    private(set) public var financeModel = RealmFinanceType()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(realmFinances: RealmFinanceType? = nil) {
        guard let realmFinances else { return }
        self.financeModel = realmFinances
        let image = UIImage(data: realmFinances.image)?.withRenderingMode(.alwaysTemplate)
        cellImage.image = image
        cellLabel.text = "\(realmFinances.type) \(realmFinances.name)"
    }
}
