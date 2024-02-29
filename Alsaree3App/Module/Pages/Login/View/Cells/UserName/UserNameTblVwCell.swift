//
//  UserNameTblVwCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class UserNameTblVwCell: UITableViewCell {

    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var lblBackView: UIView!
    @IBOutlet weak var usernameLbl: UITextField!
    @IBOutlet weak var errortext: UILabel!
    
    var errorString : String?
    var text :String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
    func setHeadingLbl(lblText:String){
        headingLbl.setProperties(lbltext: lblText, fontSize: 14)
    }
    
    func setUpErrorText(errText:String = ""){
        text = usernameLbl.text
        errortext.setProperties(lbltext: errText, fontSize: 12,color: .red)
        usernameLbl.text = text
    }
    
    func setupUi(){
        self.selectionStyle = .none
        applyCornerRadius(to: lblBackView, radius: 10,borderColor: ColorConstant.borderColorGray,borderWidth: 1)
    }
    
}