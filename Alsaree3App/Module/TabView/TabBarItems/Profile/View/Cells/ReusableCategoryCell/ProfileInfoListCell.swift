//
//  ProfileInfoListCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 29/01/24.
//

import UIKit

class ProfileInfoListCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryHeadingLbl: UILabel!
    @IBOutlet weak var categoryAdditionalLbl: UILabel!
    @IBOutlet weak var categoryRightIndicatorImg: UIImageView!
    
    var listDetails : ProfileTabDetails?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        super.awakeFromNib()
    }

    func setupUi(){
        categoryHeadingLbl
        categoryHeadingLbl.setProperties(lbltext: listDetails?.catListLabel ?? "", fontSize: 16)
        categoryAdditionalLbl.setProperties( lbltext: listDetails?.catAdditionalDetails ?? "", fontSize: 12)
        categoryImg.setProperties(imageName: listDetails?.iconName ?? "placeholder")
        categoryRightIndicatorImg.setProperties(imageName: "HalfRightArrow")
        
        baseView.layer.cornerRadius = 10
        baseView.layer.borderWidth = 0.5
        baseView.layer.borderColor = ColorConstant.borderColorGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
