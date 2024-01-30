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
        setLabelText(lblrefrence:categoryHeadingLbl , lbltext: listDetails?.catListLabel ?? "", fontSize: 16)
        setLabelText(lblrefrence: categoryAdditionalLbl, lbltext: listDetails?.catAdditionalDetails ?? "", fontSize: 12)
        setImage(imageView: categoryImg, imageName: listDetails?.iconName ?? "placeholder")
        setImage(imageView: categoryRightIndicatorImg, imageName: "HalfRightArrow")
        
        baseView.layer.cornerRadius = 10
        baseView.layer.borderWidth = 0.5
        baseView.layer.borderColor = ColorConstant.borderColorGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
