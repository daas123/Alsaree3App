//
//  SingleCategoryCollectionViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class SingleCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: Iboutlet
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    //MARK: Local Variable
    var indexPath = Int()
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                parentView.layer.borderColor = ColorConstant.borderColorYellow.cgColor
            }else{
                parentView.layer.borderColor = ColorConstant.borderColorGray.cgColor
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupUI(){
        
        categoryImg.image = UIImage(named: HomeCategoryCellList(rawValue: indexPath)?.imageName ?? "")
        if let title = HomeCategoryCellList(rawValue: indexPath)?.title{
            categoryTitle.setProperties(lbltext: title , fontSize: 10,lineHeightMultiple: 0.7)
        }
        self.backgroundColor = UIColor.clear
        
        // setup parent view border and properties
        parentView.layer.cornerRadius = 10
        parentView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        parentView.layer.borderWidth = 1
        parentView.clipsToBounds = true
        parentView.backgroundColor = ColorConstant.whitecolor
        
    }
}
