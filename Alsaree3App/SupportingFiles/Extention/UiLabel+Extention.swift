//
//  UiLabel+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 08/02/24.
//

import UIKit
extension UILabel{
    func setProperties(lbltext: String, fontSize: Int, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, color: UIColor = UIColor.black, alignmentLeft: Bool = false, lineHeightMultiple: CGFloat? = nil) {
        
        let localizedText = NSLocalizedString(lbltext, comment: "")
        self.text = localizedText
        
        if let font = isBold ? UIFont.boldSystemFont(ofSize: CGFloat(fontSize)) : UIFont(name: font_Family, size: CGFloat(fontSize)) {
            let attributedString = NSMutableAttributedString(string: localizedText)
            
            if let lineHeightMultiple = lineHeightMultiple {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineHeightMultiple = lineHeightMultiple
                attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            }
            
            self.attributedText = attributedString
            self.font = font
        }
        
        self.textColor = color
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
            self.textAlignment = alignmentLeft ? .right : .center
        } else {
            self.textAlignment = alignmentLeft ? .left : .center
        }
    }
}
