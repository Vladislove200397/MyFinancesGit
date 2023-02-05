//
//  FinanceHistoryCell.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import UIKit

class FinanceHistoryCell: UITableViewCell {
    static let id = String(describing: FinanceHistoryCell.self)

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func plusSet(sumOperation: RealmFinancePlusValueModel) {
        dateLabel.text = dateFormat(sumOperation.date)
        sumLabel.text = "+ \(sumOperation.plusValues)"
    }
    
    func minusSet(sumOperation: RealmFinanceMinusValueModel) {
        dateLabel.text = dateFormat(sumOperation.date)
        sumLabel.text = "- \(sumOperation.minusValues)"
    }
    
    private func dateFormat(_ from: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm"
        let dateString = dateFormatter.string(from: from)
        
        return dateString
    }
}
