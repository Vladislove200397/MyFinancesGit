//
//  Delegates.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 3.02.23.
//

import Foundation

protocol SetRealmDataDelegate: AnyObject {
    func setData(data: RealmFinanceType)
}
