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
    @IBOutlet var categoryLbl: [UILabel]!

    var selectedTag : Int = 1
    var originalHeigth : CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        
        setupcategoryView()
        self.backgroundColor = UIColor.clear
        originalHeigth = self.bounds.height
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let tappedView = sender.view {
            animateCell(tapView: tappedView)
        }
    }

    func animateCell(tapView : UIView){
            UIView.animate(withDuration: 0.3, animations: {
                tapView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    tapView.transform = .identity
                }completion: { (_) in
                    switch tapView.tag{
                    case 1: self.selectedTag = 1
                    case 2: self.selectedTag = 2
                    case 3: self.selectedTag = 3
                    case 4: self.selectedTag = 4
                    default : print("default")
                    }
                    self.setupcategoryView()
                }
            }
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
    
    func setupcategoryView(){
        for catview in categoryView{
            catview.layer.cornerRadius = 10
            catview.layer.borderWidth = 1
            if catview.tag == selectedTag{
                catview.layer.borderColor = ColorConstant.primaryYellowColor.cgColor
                
            }else{
                catview.layer.borderColor = ColorConstant.borderColorGray.cgColor
            }
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            catview.addGestureRecognizer(tapGesture)
        }
        
        for catlabel in categoryLbl{
            switch catlabel.tag{
            case 1:
                if catlabel.tag == selectedTag{
                    catlabel.setProperties(lbltext: "Food", fontSize: 10,isBold: true,color: ColorConstant.primaryYellowColor)
                }else{
                    catlabel.setProperties(lbltext: "Food" , fontSize: 10)
                }
            case 2:
                if catlabel.tag == selectedTag{
                    catlabel.setProperties(lbltext: "Alsaree3 Market", fontSize: 10,isBold: true, color: ColorConstant.primaryYellowColor, lineHeightMultiple: 0.8)
                }else{
                    catlabel.setProperties(lbltext: "Alsaree3 Market", fontSize: 10,lineHeightMultiple: 0.8)
                }
            case 3:
                if catlabel.tag == selectedTag{
                    catlabel.setProperties(lbltext: "Parcel", fontSize: 10,isBold: true,color: ColorConstant.primaryYellowColor)
                }else{
                    catlabel.setProperties(lbltext: "Parcel" , fontSize: 10)
                }
            case 4:
                if catlabel.tag == selectedTag{
                    catlabel.setProperties(lbltext: "More", fontSize: 10,isBold: true,color: ColorConstant.primaryYellowColor)
                }else{
                    catlabel.setProperties(lbltext: "More" , fontSize: 10)
                }
            default:
                break
            }
        }
    }
}
