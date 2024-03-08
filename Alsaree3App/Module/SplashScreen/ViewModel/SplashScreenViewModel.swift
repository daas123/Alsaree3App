//
//  SplashScreenViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import Foundation

protocol splashScreenActions{
    func navigateToAppSettingErrorState()
    func navigateToInValidAreaLocation()
    func navigateToHomeTab()
}
class SplashScreenViewModel{
    let endTime = DispatchTime.now() + 2.5
    var splashScreenDeligate : splashScreenActions?
    var isApiCallFailed = false
    
    func callSplashScreeenApis(){
        callAppSettingApi()
    }
    
    func callAppSettingApi(){
        let parameters = AppSettingParams(device_type: DeviceInfo.deviceType.rawValue, type: DeviceInfo.type.rawValue, device_token:kDeviceToken, device_unique_id:kDeviceUniqueId )
        HomeScreenServices().getAppSettings(parameters: parameters) { responce  in
            switch responce{
            case.success(let data):
                authKey = data.authKey
                SDWebImageManagerRevamp.shared.imageBaseUrl = data.imageBaseURL
                if DispatchTime.now() >= self.endTime{
                    self.splashScreenDeligate?.navigateToHomeTab()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        self.splashScreenDeligate?.navigateToHomeTab()
                    }
                }
                debugPrint("callAppSettingApi Done")
            case.failure(let error):
                debugPrint("callAppSettingApi falied")
                if DispatchTime.now() >= self.endTime{
                    self.splashScreenDeligate?.navigateToHomeTab()
                }else{
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        self.splashScreenDeligate?.navigateToHomeTab()
                    }
                }
                debugPrint(error.localizedDescription)
            }
        }
    }
}


//        dispatchGroup.notify(queue: .main) {
        
//                self.splashScreenDeligate?.navigateToHomeTab()
//            } else {
//                DispatchQueue.main.asyncAfter(deadline: .now() + (2.5 - secondsElapsed)) {
//                    self.splashScreenDeligate?.navigateToHomeTab()
//                }
//            }
//        }
