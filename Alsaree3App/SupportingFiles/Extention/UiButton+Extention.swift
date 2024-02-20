//
//  UiButton+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 08/02/24.
//

import UIKit

extension UIButton{
    
    enum ImagePosition {
        case left
        case right
    }
    
    func setProperties(label: String, color: UIColor = ColorConstant.blackcolor, size: Int, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, isUnderline: Bool = false, borderColor: UIColor = UIColor.clear,backcolor : UIColor = UIColor.clear,cornerRadius : Int = 0 ,borderWidth:CGFloat = 0 , tintcolor:UIColor = UIColor.clear) {
        
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        
        attributes[.font] = isBold ? UIFont(name: FontConstant.bold.rawValue, size: CGFloat(size)) : UIFont(name: font_Family, size: CGFloat(size))
        
        if isUnderline {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            attributes.merge(underlineAttribute) { $1 }
        }
        
        let attributedText = NSAttributedString(string: label, attributes: attributes)
        
        self.tintColor = tintcolor
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.backgroundColor = backcolor
        self.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setPropertiesWithImage(label: String, image: String, textColor: UIColor = ColorConstant.blackcolor, fontSize: Int, imageSize: CGSize, imagePosition: ImagePosition = .left, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, isUnderline: Bool = false, borderColor: UIColor = UIColor.clear, imageTintColor: UIColor? = nil,backColor:UIColor = UIColor.clear,cornerRadius:Int = 0,tintcolor:UIColor = UIColor.clear) {

        // Set button text
        setProperties(label: label, color: textColor, size: fontSize, font_Family: font_Family, isBold: isBold, isUnderline: isUnderline, borderColor: borderColor,backcolor: backColor,cornerRadius: cornerRadius,tintcolor: tintcolor)

        // Set button image
        if let originalImage = UIImage(named: image, in: nil, with: nil)?.resizedImage(with: imageSize) {

            if let tintColor = imageTintColor {
                // Tint the image with the specified color
                let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
                self.setImage(tintedImage, for: .normal)
                self.tintColor = tintColor
            } else {
                self.setImage(originalImage, for: .normal)
            }
        }

        // Set semantic content attribute and content horizontal alignment based on image position
        switch imagePosition {
        case .left:
            self.semanticContentAttribute = .forceLeftToRight
            self.contentHorizontalAlignment = .left
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Adjust the left inset as needed
        case .right:
            self.semanticContentAttribute = .forceRightToLeft
            self.contentHorizontalAlignment = .right
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Adjust the right inset as needed
        }
    }
    
    func setImageOnButton(image : String , isSystemImage : Bool = false , isAspectFill : Bool = false){
        if isSystemImage {
            self.setImage(UIImage(systemName: image), for: .normal)
        } else {
            self.setImage(UIImage(named: image), for: .normal)
        }
        
        if isAspectFill {
            self.imageView?.contentMode = .scaleAspectFill
            self.clipsToBounds = true
        }
    }
    
}
