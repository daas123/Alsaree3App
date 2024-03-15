//
//  FeatureCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//

import UIKit

class FeatureCell: UICollectionViewCell {
    
    @IBOutlet weak var featureView: UIView!
    @IBOutlet weak var featurelbl: UILabel!
    @IBOutlet weak var featureImageWithLabel: UIImageView!
    
    var feature : featureDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
        setuplblText()
    }
    
    func fillDetails(){
        featurelbl.text = feature?.featureValue
        if feature?.image == nil{
            featureImageWithLabel.isHidden = true
        }else{
            featureImageWithLabel.image = UIImage(named: feature?.image ?? "")
        }
        
        if let isTinted = feature?.istinted, isTinted {
            self.backgroundColor = ColorConstant.borderColorGray
        } else {
            self.backgroundColor = UIColor.clear
        }
        
    }
    
    func setuplblText(){
        featurelbl.setProperties(lbltext: featurelbl.text ?? "", fontSize: 10,font_Family: FontConstant.light.rawValue)
    }
    
    func setupUi(){
        self.layer.borderColor = ColorConstant.borderColorGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.backgroundColor = .lightGray
        self.featurelbl.textColor = .black
    }
    
}
