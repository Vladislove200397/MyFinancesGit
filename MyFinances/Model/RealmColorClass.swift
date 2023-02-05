//
//  RealmColorClass.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import Foundation
import RealmSwift

class RealmColorClass: Object {
    @objc dynamic var colorName = ""
    var colorComponents = List<Float>()
}
