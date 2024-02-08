//
//  HomeTabCategoryHeader.swift
//  Alsaree3App
//
//  Created by Neosoft on 25/12/23.
//

import UIKit

class HomeTabCategoryHeader: UIView {

    
    @IBOutlet var categoryView: [UIView]!
    @IBOutlet var categoryImages: [UIImageView]!
    @IBOutlet weak var alsareeMarketLbl: UILabel!
    @IBOutlet var categoryHeigthConstrain: [NSLayoutConstraint]!
    
    @IBOutlet weak var floatingBottomConstrian: NSLayoutConstraint!
    
    @IBOutlet weak var categroyBackView: UIView!
    
    
    var originalHeigth : CGFloat?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for views in categoryView{
            views.layer.cornerRadius = 10
            views.layer.borderColor = ColorConstant.borderColorGray.cgColor
            views.layer.borderWidth = 1
            
        }
        self.backgroundColor = UIColor.clear
        // Initialization code
        
        alsareeMarketLbl.setProperties(lbltext: "Alsaree3 Market", fontSize: 10,lineHeightMultiple: 0.7)
        
        originalHeigth = self.bounds.height
    }
    
    func hideImages(){
        for images in categoryImages{
            images.isHidden = true
        }
        
        for heigthConstrain in categoryHeigthConstrain{
            heigthConstrain.constant = 0
        }
        
    }
    
    func showImages(){
        for images in categoryImages{
            images.isHidden = false
        }
        
        for heigthConstrain in categoryHeigthConstrain{
            heigthConstrain.constant = 32
        }
    }
    
    func setCustomConstrain(heigtht:Int = 40){
        UIView.animate(withDuration: 0.9) {
            self.floatingBottomConstrian.constant = CGFloat(heigtht)
            }
    }
    
    func setDefaultConstrain(){
        floatingBottomConstrian.constant = 0
    }

}
