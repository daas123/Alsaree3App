//
//  StaticAlert.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 20/02/24.
//

import UIKit

class StaticAlert: UIView {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var messageLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        parentView.layer.cornerRadius = 10
        parentView.backgroundColor = ColorConstant.primaryYellowColor
    }
    
    func setupMessageLbl(errorText:String){
        messageLbl.setProperties(lbltext: errorText , fontSize: 16,color: ColorConstant.whitecolor)
    }
    
}
