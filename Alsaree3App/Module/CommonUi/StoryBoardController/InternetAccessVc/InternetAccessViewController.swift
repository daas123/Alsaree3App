//
//  InternetAccessViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/01/24.
//

import UIKit

class InternetAccessViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onGrantPermissionBtn(_ sender: UIButton) {
        
        if let settingsURL = URL(string: "App-Prefs:root=WIFI") {
                UIApplication.shared.open(settingsURL)
            }
        
        if let settingsURL = URL(string: "App-Prefs:root=MOBILE_DATA_SETTINGS_ID") {
                UIApplication.shared.open(settingsURL)
            }
        
        
        
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
    }
    
}
//
//
//import Network
//
//func checkNetworkStatus() {
//    let monitor = NWPathMonitor()
//    monitor.pathUpdateHandler = { path in
//        if path.status == .satisfied {
//            // User is connected to a network (either Wi-Fi or cellular data)
//            if path.usesInterfaceType(.wifi) {
//                // User is connected to Wi-Fi
//                openSettingsForWi-Fi()
//            } else {
//                // User is connected to cellular data
//                openSettingsForMobileData()
//            }
//        } else {
//            // User is not connected to any network
//            // Handle this case as needed
//        }
//    }
//    monitor.start(queue: DispatchQueue.global())
//}

//func openSettingsForWi-Fi() {
//    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
//        UIApplication.shared.open(settingsURL)
//    }
//}
//
//func openSettingsForMobileData() {
//    // Replace with the appropriate identifier for mobile data settings
//    if let settingsURL = URL(string: "App-Prefs:root=MOBILE_DATA_SETTINGS_ID") {
//        UIApplication.shared.open(settingsURL)
//    }
//}
