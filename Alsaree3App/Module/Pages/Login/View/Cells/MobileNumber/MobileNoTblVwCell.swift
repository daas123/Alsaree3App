//
//  MobileNoTblVwCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class MobileNoTblVwCell: UITableViewCell {
    
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var lblBackView: UIView!
    @IBOutlet weak var mobileNoLbl: UITextField!
    @IBOutlet weak var cntyCodeSelector: UILabel!
    @IBOutlet weak var errorText: UILabel!
    
    var loginVcDeligate : updateMobileNoError?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
    
    func setHeadingLbl(lblText:String){
        headingLbl.setProperties(lbltext: lblText, fontSize: 14)
    }
    
    func setUpErrorText(errText:String = ""){
        errorText.setProperties(lbltext: errText, fontSize: 12,color: .red)
    }
    
    func setupUi(){
        self.selectionStyle = .none
        applyCornerRadius(to: lblBackView, radius: 10,borderColor: ColorConstant.borderColorGray,borderWidth: 1)
        cntyCodeSelector.setProperties(lbltext: "+964", fontSize: 12)
        errorText.setProperties(lbltext: "", fontSize: 12)
    }
}