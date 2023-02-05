//
//  RealmFinancePlusValueModel.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import Foundation
import RealmSwift

class RealmFinancePlusValueModel: Object {
    @objc dynamic var plusValues: Double = 0.0
    @objc dynamic var date = Date()
    
    convenience init(plusValues: Double, date: Date) {
        self.init()
        self.plusValues = plusValues
        self.date = date
    }
}
