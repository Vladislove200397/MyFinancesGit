//
//  RealmFinanceMinusValueModel.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import Foundation
import RealmSwift

class RealmFinanceMinusValueModel: Object {
    @objc dynamic var minusValues: Double = 0.0
    @objc dynamic var date = Date()
    
    convenience init(minusValues: Double, date: Date) {
        self.init()
        self.minusValues = minusValues
        self.date = date
    }
}
