//
//  LoginViewTextFieldDelegate.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 29/02/24.
//

import Foundation
import UIKit

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let pointInTable = textField.convert(textField.bounds.origin, to: self.loginTableView)
        let textFieldIndexPath = self.loginTableView.indexPathForRow(at: pointInTable)
        if let indexPath = textFieldIndexPath {
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if let nextCell = self.loginTableView.cellForRow(at: nextIndexPath) {
                switch nextIndexPath.row {
                case 1:
                    (nextCell as? MobileNoTblVwCell)?.mobileNoLbl.becomeFirstResponder()
                case 2:
                    if isUserWantsReferal {
                        (nextCell as? ReferralCodeTblVwCell)?.referralCodeLbl.becomeFirstResponder()
                    }else{
                        textField.resignFirstResponder()
                    }
                default:
                    textField.resignFirstResponder()
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField.tag{
        case 1:
            if let userNameText = textField.text{
                let indexPath = IndexPath(item: 0, section: 0)
                weak var cell = loginTableView.cellForRow(at: indexPath) as? UserNameTblVwCell
                if let userNameError = ValidationManager().userNameValidation(userName: userNameText){
                    viewModel.userNameErorr = userNameError
                    cell?.errortext.text = userNameError
                }else{
                    viewModel.userNameErorr = nil
                    if !viewModel.isAnyError(){
                        updateProceedBtn(isActive: true)
                    }
                    cell?.errortext.text = ""
                }
            }
        case 2:
            if let mobileNoText = textField.text{
                let indexPath = IndexPath(item: 1, section: 0)
                weak var cell = loginTableView.cellForRow(at: indexPath) as? MobileNoTblVwCell
                if let mobileNoError = ValidationManager().mobileNoValidation(mobileNo: mobileNoText){
                    viewModel.mobileNoErorr = mobileNoError
                    cell?.errorText.text = mobileNoError
                }else{
                    viewModel.mobileNoErorr = nil
                    if !viewModel.isAnyError(){
                        updateProceedBtn(isActive: true)
                    }
                    cell?.errorText.text = ""
                }
            }
        default:
            return
        }
    }
    
    
}
