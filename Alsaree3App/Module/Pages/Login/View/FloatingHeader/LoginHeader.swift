//
//  LoginHeader.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class LoginHeader: UIView {

    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    override func awakeFromNib() {
    }
    override func layoutSubviews() {
        addBottomBorderWithColor(color:ColorConstant.borderColorGray , width: 1)
    }
    
    func setHeaderLbl(){
        headerLbl.setProperties(lbltext: "Log in", fontSize: 20,alignmentLeft: true)
    }

}
