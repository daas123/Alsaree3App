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
        messageLbl.setProperties(lbltext: "Some thing went Wrong,try to Check your Internet Access or Location Access", fontSize: 16)
    }
    
}
