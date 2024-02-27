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

}
