//
//  UIView+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft on 15/12/23.
//

import Foundation
import UIKit

extension UIView{
    enum ImagePosition {
        case left
        case right
    }

    func setButtonText(button: UIButton, label: String, color: UIColor = ColorConstant.blackcolor, size: Int, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, isUnderline: Bool = false, borderColor: UIColor = UIColor.clear,backcolor : UIColor = UIColor.clear,cornerRadius : Int = 0) {
        
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        
        attributes[.font] = isBold ? UIFont(name: FontConstant.bold.rawValue, size: CGFloat(size)) : UIFont(name: font_Family, size: CGFloat(size))
        
        if isUnderline {
            let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
            attributes.merge(underlineAttribute) { $1 }
        }
        
        let attributedText = NSAttributedString(string: label, attributes: attributes)
        
        button.layer.cornerRadius = CGFloat(cornerRadius)
        button.layer.borderColor = borderColor.cgColor
        button.backgroundColor = backcolor
        button.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setButtonWithTextAndImage(button: UIButton, label: String, image: String, textColor: UIColor = ColorConstant.blackcolor, fontSize: Int, imageSize: CGSize, imagePosition: ImagePosition = .left, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, isUnderline: Bool = false, borderColor: UIColor = UIColor.clear, imageTintColor: UIColor? = nil,backColor:UIColor = UIColor.clear,cornerRadius:Int = 0) {

        // Set button text
        setButtonText(button: button, label: label, color: textColor, size: fontSize, font_Family: font_Family, isBold: isBold, isUnderline: isUnderline, borderColor: borderColor,backcolor: backColor,cornerRadius: cornerRadius)

        // Set button image
        if let originalImage = UIImage(named: image, in: nil, with: nil)?.resizedImage(with: imageSize) {

            if let tintColor = imageTintColor {
                // Tint the image with the specified color
                let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
                button.setImage(tintedImage, for: .normal)
                button.tintColor = tintColor
            } else {
                button.setImage(originalImage, for: .normal)
            }
        }

        // Set semantic content attribute and content horizontal alignment based on image position
        switch imagePosition {
        case .left:
            button.semanticContentAttribute = .forceLeftToRight
            button.contentHorizontalAlignment = .left
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0) // Adjust the left inset as needed
        case .right:
            button.semanticContentAttribute = .forceRightToLeft
            button.contentHorizontalAlignment = .right
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Adjust the right inset as needed
        }
    }
    
    func setLabelText(lblrefrence: UILabel, lbltext: String, fontSize: Int, font_Family: String = FontConstant.regular.rawValue, isBold: Bool = false, color: UIColor = UIColor.black, alignmentLeft: Bool = false, lineHeightMultiple: CGFloat? = nil) {
        
        let localizedText = NSLocalizedString(lbltext, comment: "")
        lblrefrence.text = localizedText
        
        if let font = isBold ? UIFont.boldSystemFont(ofSize: CGFloat(fontSize)) : UIFont(name: font_Family, size: CGFloat(fontSize)) {
            let attributedString = NSMutableAttributedString(string: localizedText)
            
            if let lineHeightMultiple = lineHeightMultiple {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineHeightMultiple = lineHeightMultiple
                attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            }
            
            lblrefrence.attributedText = attributedString
            lblrefrence.font = font
        }
        
        lblrefrence.textColor = color
        
        if UIView.userInterfaceLayoutDirection(for: lblrefrence.semanticContentAttribute) == .rightToLeft {
            lblrefrence.textAlignment = alignmentLeft ? .right : .center
        } else {
            lblrefrence.textAlignment = alignmentLeft ? .left : .center
        }
    }

    
    func setImage(imageView: UIImageView, imageName: String, isAspectFit: Bool = true, isSystemImage: Bool = false) {
        if isSystemImage {
            imageView.image = UIImage(systemName: imageName)
        } else {
            imageView.image = UIImage(named: imageName)
        }
        
        if isAspectFit {
            imageView.contentMode = .scaleAspectFit
        } else {
            imageView.contentMode = .scaleToFill
        }
    }
    
    func setCircleWithBorderColor(imageView:UIImageView , borderColor : UIColor , borderWidth : Int){
        imageView.layer.cornerRadius = (imageView.bounds.width) / 2
        imageView.layer.borderColor = borderColor.cgColor
        imageView.layer.borderWidth = CGFloat(borderWidth)
    }
    
    
    func setImageOnButton(button : UIButton , image : String , isSystemImage : Bool = false , isAspectFill : Bool = false){
        if isSystemImage {
            button.setImage(UIImage(systemName: image), for: .normal)
        } else {
            button.setImage(UIImage(named: image), for: .normal)
        }
        
        if isAspectFill {
            button.imageView?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
        }
    }
    
    
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
    
    func applyShadow(to view: UIView) {
        
    }
    
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
}
