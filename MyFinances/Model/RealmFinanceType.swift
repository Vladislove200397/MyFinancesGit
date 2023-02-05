//
//  RealmFinanceType.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 3.02.23.
//

import Foundation
import RealmSwift
import Charts

class RealmFinanceType: Object {
    @objc dynamic var name = ""
    @objc dynamic var type = ""
    @objc dynamic var image = Data()
    @objc dynamic var value: Double = 0.0
    var minusValues = List<RealmFinanceMinusValueModel>()
    var plusValues = List<RealmFinancePlusValueModel>()
    @objc dynamic var color: RealmColorClass?
    @objc dynamic var id: Int = 0

    
    convenience init(name: String, type: String, image: Data, value: Double, plusValues: List<RealmFinancePlusValueModel>, minusValues: List<RealmFinanceMinusValueModel>, id: Int) {
        self.init()
        self.name = name
        self.type = type
        self.image = image
        self.value = value
        self.plusValues = plusValues
        self.minusValues = minusValues
        self.id = id
    }
}
