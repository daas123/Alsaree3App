//
//  FoodCatCollectionViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class FoodCatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    var singleFoodCategoryData : TagsRevamp?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        foodImage.layer.cornerRadius = foodImage.bounds.width/2
        foodImage.clipsToBounds = true
    }
    
    func setupUI(){
        categoryTitle.setProperties(lbltext: singleFoodCategoryData?.name ?? "", fontSize: 12)
        SDWebImageManagerRevamp.shared.loadImage(with: singleFoodCategoryData?.image_url ?? "", into: foodImage)
        foodImage.layer.borderWidth = 0
        
        self.backgroundColor = UIColor.clear
    }
    
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                foodImage.layer.borderWidth = 1
                foodImage.layer.borderColor = ColorConstant.primaryYellowColor.cgColor
                categoryTitle.textColor = ColorConstant.primaryYellowColor
            }else{
                foodImage.layer.borderWidth = 0
                categoryTitle.textColor = ColorConstant.blackcolor
                
            }
        }
    }
    
}
