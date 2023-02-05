//
//  UiViewExtension.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 2.02.23.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(topColor: CGColor, bottomColor: CGColor) {
         let colorTop =  topColor
         let colorBottom = bottomColor
         
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [colorTop, colorBottom]
         gradientLayer.locations = [0.0, 0.5]
         gradientLayer.frame = self.bounds
         
        self.layer.insertSublayer(gradientLayer, at:0)
     }
    
    func addBlurredBackground(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
        self.sendSubviewToBack(blurView)
    }
}
