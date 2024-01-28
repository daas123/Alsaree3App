//
//  BaseViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/01/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationManager().addObserver(forName: .networkStatusChanged) { _  in
            self.networkStatusDidChange()
        }
        NotificationManager().addObserver(forName: .networkStatusChanged) { _  in
            self.locationStatusChanged()
        }
        NotificationManager().addObserver(forName: .noLocationDeliverable) { _ in
            
        }
    }
    
    func networkStatusDidChange() {
            let storyboard = UIStoryboard(name: "CommonScreens", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier:"InternetAccessViewController") as! InternetAccessViewController
            self.present(viewController, animated: true, completion: nil)
    }
    
    func locationStatusChanged(){
            let storyboard = UIStoryboard(name: "CommonScreens", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier:"LocationAccessViewController") as! LocationAccessViewController
            self.present(viewController, animated: true, completion: nil)
    }
    
    
    func noLocationDeliverable(){
            let storyboard = UIStoryboard(name: "CommonScreens", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier:"LocationAccessViewController") as! LocationAccessViewController
            self.present(viewController, animated: true, completion: nil)
    }
    
   
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .networkStatusChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: .locationAccessRestricted, object: nil)
        NotificationCenter.default.removeObserver(self, name: .noLocationDeliverable, object: nil)
    }
    
}