//
//  MoneyType.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import Foundation
import UIKit

enum MoneyType: String, CaseIterable {
    case byn = "BYN"
    case eur = "EUR"
    case doll = "USD"
    case gold = "Золото"
    case silv = "Серебро"
    case plat = "Платина"
}

extension MoneyType {
    var image: UIImage {
        switch self {
            case .byn:
                return UIImage(named: "rouble")!
            case .eur:
                return UIImage(named: "euro")!
            case .doll:
                return UIImage(named: "dollar")!
            case .gold:
                return UIImage(named: "gold")!
            case .silv:
                return UIImage(named: "silver")!
            case .plat:
                return UIImage(named: "platinum")!
        }
    }
}
