//
//  NSUIColorExtension.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 5.02.23.
//

import Foundation
import Charts

extension UIColor {
    static var random: UIColor {
        let max = CGFloat(UInt32.max)
        let red = CGFloat(arc4random()) / max
        let green = CGFloat(arc4random()) / max
        let blue = CGFloat(arc4random()) / max

        return UIColor(red: red, green: green, blue: blue, alpha: 0.7)
    }
}
