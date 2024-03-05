//
//  LoginViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import Foundation
class LoginViewModel{
    var loginDelegate : viewModelActions?
    var userNameErorr : String? = ""
    var mobileNoErorr : String? = ""
    var countrylist : [Country]?
    
    func setupUsernameError()->String{
        return userNameErorr ?? ""
    }
    
    func setupMobileNoError() -> String{
        return mobileNoErorr ?? ""
    }
    
    func isAnyError()->Bool{
        if userNameErorr == nil && mobileNoErorr == nil{
            return false
        }else{
            return true
        }
    }
    
    func getpresentingHeight(screenHeigth:CGFloat) -> Double{
        if screenHeigth > 890 {
            return 0.55
        } else if screenHeigth > 700 {
            return 0.61
        } else {
            return 0.73
        }
    }
    
    func getCountryList(){
        LoginScreenServices().getCountryList { responce in
            switch responce{
            case.success(let data):
                print(data)
                self.countrylist = data.countries
                self.loginDelegate?.reloadLoginTableView()
                debugPrint("getCountryList Done")
            case.failure(let error):
                debugPrint("getCountryList falied")
                debugPrint(error.localizedDescription)
            }
        }
    }
}
