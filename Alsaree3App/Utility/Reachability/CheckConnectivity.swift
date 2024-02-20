//
//  CheckConnectivity.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 12/02/24.
//

import Foundation
class Connectivity{
    
    static func checkNetAndLoc(isPresentScreen:Bool = true) -> Bool{
        if !ReachabilityRevamp.isConnectedToNetwork() {
            if isPresentScreen{
                NotificationManager().postNetworkStatusChanged()
            }
            return false
        }
        
        if !LocationManagerRevamp.shared.isLocationAccess {
            if isPresentScreen{
                NotificationManager().postLocationAccessRestricted()
            }
            return false
        }
        
        return true
    }
    
    static func checkLocationAccess(isPresentScreen:Bool = true) -> Bool{
        if !LocationManagerRevamp.shared.isLocationAccess {
            if isPresentScreen{
                NotificationManager().postLocationAccessRestricted()
            }
            return false
        }
        return true
    }
    
    static func checkInternetAccess(isPresentScreen:Bool = true) -> Bool{
        if !ReachabilityRevamp.isConnectedToNetwork() {
            if isPresentScreen{
                NotificationManager().postNetworkStatusChanged()
            }
            return false
        }
        return true
    }
}
