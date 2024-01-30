//
//  ProfileTabViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 30/01/24.
//

import Foundation
class ProfileTabViewModel{
    var islogin = true
    
    func getTableViewCount() -> Int{
        if islogin{
            return 8
        }else{
            return 1
        }
    }
    
    
}
