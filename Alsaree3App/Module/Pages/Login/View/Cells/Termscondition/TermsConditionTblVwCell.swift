//
//  TermsConditionTblVwCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import UIKit

class TermsConditionTblVwCell: UITableViewCell {

    @IBOutlet weak var termsAndConditionlbl: UILabel!
    @IBOutlet weak var chkBoxbtn: UIButton!
    
    var loginviewControllerDeligate : updateProceedbtnState?
    var isChkBoxSelected = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUi()
    }
    
    override func layoutSubviews() {
        addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
    }
    
    func setUpUi(){
        chkBoxbtn.setProperties(label: "", size: 0)
        isChkBoxSelected ? chkBoxbtn.setImageOnButton(image: "checkboxSelected") : chkBoxbtn.setImageOnButton(image: "checkbox")
    }
    
    func setTermsConditionLbl(text:String){
        termsAndConditionlbl.setProperties(lbltext: text , fontSize: 14,alignmentLeft: true,lineHeightMultiple: 0.9)
        
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Privacy Policy")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: FontConstant.regular.rawValue, size: 14)!, range: range1)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorConstant.primaryYellowColor.cgColor, range: range1)
        
        let range2 = (text as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value: UIFont.init(name: FontConstant.regular.rawValue, size: 14)!, range: range2)
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorConstant.primaryYellowColor.cgColor, range: range2)
        
        termsAndConditionlbl.attributedText = underlineAttriString
        termsAndConditionlbl.isUserInteractionEnabled = true
        termsAndConditionlbl.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        
        let termsRange = (termsAndConditionlbl.text! as NSString).range(of: "Privacy Policy")
        let privacyRange = (termsAndConditionlbl.text! as NSString).range(of: "Terms & Conditions")
        
        if gesture.didTapAttributedTextInLabel(label:termsAndConditionlbl , inRange: termsRange) {
            print("Tapped Terms and condition")
        }else if gesture.didTapAttributedTextInLabel(label: termsAndConditionlbl, inRange: privacyRange) {
            print("Tapped privacy")
        }else {
            print("Tapped none")
        }
    }
    
    @IBAction func chkBoxBtnClicked(_ sender: UIButton) {
        isChkBoxSelected.toggle()
        isChkBoxSelected ? chkBoxbtn.setImageOnButton(image: "checkboxSelected") : chkBoxbtn.setImageOnButton(image: "checkbox")
        loginviewControllerDeligate?.updateProceedBtn(isActive: isChkBoxSelected)
    }
}

