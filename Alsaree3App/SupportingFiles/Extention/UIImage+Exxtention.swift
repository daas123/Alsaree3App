//
//  UIImage+Exxtention.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 08/02/24.
//

import UIKit
extension UIImageView{
    func setProperties(imageName: String, isAspectFit: Bool = true, isSystemImage: Bool = false) {
        if isSystemImage {
            self.image = UIImage(systemName: imageName)
        } else {
            self.image = UIImage(named: imageName)
        }
        
        if isAspectFit {
            self.contentMode = .scaleAspectFit
        } else {
            self.contentMode = .scaleToFill
        }
    }
    
    func setPropertiesCircleWithBorderColor(borderColor : UIColor , borderWidth : Int){
        self.layer.cornerRadius = (self.bounds.width) / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = CGFloat(borderWidth)
    }
}
