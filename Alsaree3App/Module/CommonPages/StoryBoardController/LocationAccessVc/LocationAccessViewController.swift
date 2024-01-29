//
//  LocationAccessViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 16/01/24.
//

import UIKit

class LocationAccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onGrantPermissionClick(_ sender: UIButton) {
        openAppSettings()
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, completionHandler: nil)
        }
    }

}
