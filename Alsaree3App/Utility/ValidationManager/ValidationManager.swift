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
        
        if userName.isEmpty {
            return "UserName Cannot be Empty"
        }
        
        guard !(userName.contains(" ")) else{
            return "Username Should No Contain Spaces"
        }
        
        guard userName.count >= 3 else{
            return "Username Must be Greater then 3 Word"
        }
        
        return nil
    }
    
    func mobileNoValidation(mobileNo:String)->String?{
        if mobileNo.isEmpty {
            return "Mobile Number Cannot be Empty"
        }
        
        guard !(mobileNo.contains(" ")) else{
            return "Mobile Number Should No Contain Spaces"
        }
        
        guard mobileNo.count == 10 else{
            return "Mobile Number Must be Equal to 10"
        }
        
        guard !(mobileNo.hasPrefix("0")) else{
            return "Number should not start from 0"
        }
        
        if (mobileNo.hasPrefix("75") || mobileNo.hasPrefix("77") || mobileNo.hasPrefix("78") || mobileNo.hasPrefix("79") || mobileNo.hasPrefix("900800700") || mobileNo.hasPrefix("900900")) {} else{
            return "Number should start from 79, 78, 77, 75"
        }
        
//        guard mobileNo.hasPrefix("964") else{
//            return ""
//        }
        
        return nil
    }
}
