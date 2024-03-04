//
//  LoginPickerViewDelegate.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 04/03/24.
//

import UIKit

extension LoginViewController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countrylist?.count ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if viewModel.countrylist?.count == 0 || viewModel.countrylist == nil  {
            return "NA"
        }
        return viewModel.countrylist?[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let indexPath = IndexPath(item: 1, section: 0)
        let cell = loginTableView.cellForRow(at: indexPath) as! MobileNoTblVwCell
        cell.cntyCodeLbl.text = viewModel.countrylist?[row].countryPhoneCode
    }
    
}
