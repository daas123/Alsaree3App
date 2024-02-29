//
//  ValidationManager.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 27/02/24.
//

import Foundation
class ValidationManager{
    func loginValidation(userName:String,mobileNo:String)->String?{
        if let userNameError = userNameValidation(userName: userName){
            return userNameError
        }
        
        if let mobileNoError = mobileNoValidation(mobileNo:mobileNo){
            return mobileNoError
        }
        
        return nil
    }
    
    func userNameValidation(userName:String)->String?{
        guard userName != "" else{
            return "UserName Cannot be Empty"
        }
        
        if userName == "Hello"{
            return "You have entered Hello"
        }
        
        return nil
    }
    
    func mobileNoValidation(mobileNo:String)->String?{
        guard mobileNo != "" else{
            return "Password is Empty"
        }
        return nil
    }
}
