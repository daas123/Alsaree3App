//
//  LoginViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 26/02/24.
//

import Foundation
class LoginViewModel{
    var userNameErorr : String? = ""
    var mobileNoErorr : String? = ""
    
    func setupUsernameError()->String{
        return userNameErorr ?? ""
    }
    
    func setupMobileNoError() -> String{
        return mobileNoErorr ?? ""
    }
    
    func getCountryList(){
        LoginScreenServices().getCountryList { responce in
            switch responce{
            case.success(let data):
                print(data)
                debugPrint("getCountryList Done")
            case.failure(let error):
                debugPrint("getCountryList falied")
                debugPrint(error.localizedDescription)
            }
        }
    }
}
