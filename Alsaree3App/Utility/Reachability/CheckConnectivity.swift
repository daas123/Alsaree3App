//
//  CheckConnectivity.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 12/02/24.
//

import Foundation
class Connectivity{
    
    static func checkNetAndLoc() -> Bool{
        if !ReachabilityRevamp.isConnectedToNetwork() {
            NotificationManager().postNetworkStatusChanged()
            return false
        }
        
        if !LocationManagerRevamp.shared.isLocationAccess {
            NotificationManager().postLocationAccessRestricted()
            return false
        }
        
        return true
    }
    
    static func checkLocationAccess() -> Bool{
        if !LocationManagerRevamp.shared.isLocationAccess {
            NotificationManager().postLocationAccessRestricted()
            return false
        }
        return true
    }
    
    static func checkInternetAccess() -> Bool{
        if !ReachabilityRevamp.isConnectedToNetwork() {
            NotificationManager().postNetworkStatusChanged()
            return false
        }
        return true
    }
}
