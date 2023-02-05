//
//  UIImageExtension.swift
//  MyFinances
//
//  Created by Vlad Kulakovsky  on 4.02.23.
//

import Foundation
import UIKit

extension UIImage {
    ///Create image from string
    func imageWith(_ string: String) -> UIImage? {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 50)
        nameLabel.text = "\(string)"
        UIGraphicsBeginImageContext(frame.size)
        
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
}
