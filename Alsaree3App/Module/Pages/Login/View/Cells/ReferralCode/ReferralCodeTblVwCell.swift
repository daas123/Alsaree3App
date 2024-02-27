//
//  ReferralCodeTblVwCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class ReferralCodeTblVwCell: UITableViewCell {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var optionalLbl: UILabel!
    @IBOutlet weak var lblBackView: UIView!
    @IBOutlet weak var referralCodeLbl: UITextField!
    @IBOutlet weak var refApplyBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }

    func setHeadingLbl(lblText:String){
        headingLbl.setProperties(lbltext: lblText, fontSize: 14)
    }
    
    func setupUi(){
        self.selectionStyle = .none
        lblBackView.applyCornerRadius(to: self, radius: 10, borderColor: ColorConstant.borderColorGray)
        refApplyBtn.setProperties(label: "  Apply  ", size: 16,borderColor: ColorConstant.primaryYellowColor,cornerRadius:10, borderWidth: 1)
        optionalLbl.setProperties(lbltext: "(Optional)", fontSize: 12,color: ColorConstant.borderColorGray)
        applyCornerRadius(to: lblBackView, radius: 10,borderColor: ColorConstant.borderColorGray,borderWidth: 1)
    }
    
    @IBAction func onApplyBtnClick(_ sender: UIButton) {
        debugPrint("Apply btn Clicked")
    }
    
    
}
