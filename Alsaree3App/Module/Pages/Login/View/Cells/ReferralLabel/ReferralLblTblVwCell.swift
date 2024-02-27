//
//  ReferralLblTblVwCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class ReferralLblTblVwCell: UITableViewCell {
    
    @IBOutlet weak var referralLbl: UILabel!
    var profileTabdeligate : LoginCellAlignment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUi()
    }
    
    func setHeadingLbl(lblText:String){
        referralLbl.setProperties(lbltext: lblText, fontSize: 14,alignmentLeft: true,lineHeightMultiple: 0.8)
        let underlineAttriString = NSMutableAttributedString(string: lblText)
        let range1 = (lblText as NSString).range(of: "Press here to enter referral code")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: FontConstant.regular.rawValue, size: 14)!, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorConstant.primaryYellowColor.cgColor, range: range1)
        referralLbl.attributedText = underlineAttriString
        referralLbl.isUserInteractionEnabled = true
        referralLbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        let termsRange = (referralLbl.text! as NSString).range(of: "Press here to enter referral code")
        
        if gesture.didTapAttributedTextInLabel(label: referralLbl, inRange: termsRange) {
            profileTabdeligate?.addReferalCodecell()
        }else {
            print("Tapped none")
        }
    }
    
    func setupUi(){
        self.selectionStyle = .none
    }
    
}
