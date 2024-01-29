//
//  SomeThingwentWrong.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 29/01/24.
//

import UIKit

class SomeThingwentWrong: BaseViewController {
    
    
    var viewModel = SplashScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func checkErrorState(){
        
        if !Reachability.isConnectedToNetwork(){
            NotificationManager().postNetworkStatusChanged()
        }
        
        LocationManager.shared.requestLocationPermission(completion: { islocationaccess in
            if !islocationaccess{
                NotificationManager().postLocationAccessRestricted()
            }
        })
        
    }
    
    func pushToHometab(){
        let storyboard = UIStoryboard(name: StoryBoardConstant.main.rawValue, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
        }
    }
    
    @IBAction func onReteryBtn(_ sender: UIButton) {
        let parameters = AppSettingParams(device_type: DeviceInfo.deviceType.rawValue, type: DeviceInfo.type.rawValue, device_token:kDeviceToken, device_unique_id:kDeviceUniqueId )
        HomeScreenServices().getAppSettings(parameters: parameters) { responce  in
            switch responce{
            case.success(let data):
                authKey = data.authKey
                SDWebImageManager.shared.imageBaseUrl = data.imageBaseURL
                DispatchQueue.main.async {
                    self.pushToHometab()
                }
                debugPrint("callAppSettingApi Done")
            case.failure(let error):
                debugPrint("callAppSettingApi falied")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
}

