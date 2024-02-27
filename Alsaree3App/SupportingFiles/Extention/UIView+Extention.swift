//
//  UIView+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft on 15/12/23.
//

import Foundation
import UIKit

extension UIView{
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: UIScreen.main.bounds.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    //    func applyShadow(to view: UIView) {
    //
    //    }
    
    func coloredText(text: String, range: NSRange, color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        if let cairoFont = UIFont(name: FontConstant.bold.rawValue, size: 12) {
            attributedString.addAttribute(.font, value: cairoFont, range: range)
        } else {
            debugPrint("Error loading Cairo-Bold font")
        }
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        return attributedString
    }
    
    enum Corner {
        case Left, Right, Bottom, Top, All
    }
    
    func applyCornerRadius(to view: UIView, radius: CGFloat, corners: Corner = .All ,borderColor : UIColor = UIColor.clear,borderWidth : CGFloat = 0) {
        view.clipsToBounds = true
        view.layer.borderColor = borderColor.cgColor
        view.layer.cornerRadius = radius
        view.layer.borderWidth = borderWidth
        
        switch corners {
        case .Top:
            view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        case .Right:
            view.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        case .Left:
            view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner]
        case .Bottom:
            view.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        case .All:
            view.layer.cornerRadius = radius
        }
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
