//
//  goldCategoryCardCellTableViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//

import UIKit

class GoldCategoryCardCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var goldCatCardTitle: UILabel!
    @IBOutlet weak var goldCaterogryLbl: UILabel!
    @IBOutlet weak var customProgressView: UIView!
    @IBOutlet weak var progressBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        let customProgress = CustomProgressView(frame: customProgressView.bounds)
        customProgressView.addSubview(customProgress)
        customProgress.progress = 0.2
    }
    
    func setupUI(){
        goldCatCardTitle.setProperties(lbltext: TextConstant.yourGoldCategoryCard.rawValue,fontSize: 16 , isBold: true ,alignmentLeft: true)
        
        let range = NSRange(location: 0, length: 18)
        let coloredText = coloredText(text:TextConstant.goldCategoryCard.rawValue , range: range, color: ColorConstant.primaryYellowColor)
        
        goldCaterogryLbl.setProperties(lbltext: TextConstant.youveplacedthreeorderswithusOrdermoretoobtainour.rawValue, fontSize: 12, color: ColorConstant.blackcolor,alignmentLeft: true,lineHeightMultiple: 0.7)
        
        if let currentAttributedText = goldCaterogryLbl.attributedText {
            let mutableAttributedText = NSMutableAttributedString(attributedString: currentAttributedText)
            mutableAttributedText.append(coloredText)
            goldCaterogryLbl.attributedText = mutableAttributedText
        }
        
        progressBtn.layer.cornerRadius = progressBtn.bounds.height/2
        
        self.selectionStyle = .none
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
