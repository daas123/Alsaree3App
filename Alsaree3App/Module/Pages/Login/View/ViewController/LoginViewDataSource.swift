//
//  loginTableViewDataSource.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 29/02/24.
//

import Foundation
import UIKit
extension LoginViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.getCell(identifier: "UserNameTblVwCell") as! UserNameTblVwCell
            cell.usernameLbl.delegate = self
            cell.setHeadingLbl(lblText: "User Name")
            cell.setUpErrorText(errText: viewModel.setupUsernameError())
            return cell
        case 1:
            let cell = tableView.getCell(identifier: "MobileNoTblVwCell") as! MobileNoTblVwCell
            cell.mobileNoLbl.delegate = self
            cell.loginVcDeligate = self
            cell.cntyCodeLbl.inputView = pickerView
            cell.cntyCodeLbl.text = viewModel.countrylist?[0].countryPhoneCode
            cell.setHeadingLbl(lblText: "Mobile Number")
            cell.setUpErrorText(errText: viewModel.setupMobileNoError())
            return cell
        case 2:
            if isUserWantsReferal{
                let cell = tableView.getCell(identifier: "ReferralCodeTblVwCell") as! ReferralCodeTblVwCell
                cell.referralCodeLbl.delegate = self
                cell.setHeadingLbl(lblText: "Referral Code")
                return cell
            }else{
                let cell = tableView.getCell(identifier: "ReferralLblTblVwCell") as! ReferralLblTblVwCell
                cell.setHeadingLbl(lblText: "Did your friend refer you? Press here to enter referral code")
                cell.profileTabdeligate = self
                return cell
            }
        case 3:
            let cell = tableView.getCell(identifier: "TermsConditionTblVwCell") as! TermsConditionTblVwCell
            cell.setTermsConditionLbl(text: "By continuing with login, you agree to have read and accept our Terms & Conditions and Privacy Policy")
            cell.loginviewControllerDeligate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}
