//
//  ProfileTabViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 30/01/24.
//

import Foundation
class ProfileTabViewModel{
    var islogin = false
    
    func getTableViewCount() -> Int{
        if islogin{
            return profiletabDemoData.count + 1
        }else{
            return 2
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
    
}
