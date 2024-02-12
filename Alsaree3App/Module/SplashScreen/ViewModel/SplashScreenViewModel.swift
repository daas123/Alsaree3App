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
    
    let dispatchGroup = DispatchGroup()
    var splashScreenDeligate : splashScreenActions?
    var isApiCallFailed = false
    
    func callSplashScreeenApis(){
        let startTime = DispatchTime.now()
        dispatchGroup.enter()
        callAppSettingApi()
        dispatchGroup.notify(queue: .main) {
            let endTime = DispatchTime.now()
            let timeElapsed = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
            let secondsElapsed = Double(timeElapsed) / 1_000_000_000
            
            if secondsElapsed >= 2.5 {
                self.splashScreenDeligate?.navigateToHomeTab()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + (2.5 - secondsElapsed)) {
                    self.splashScreenDeligate?.navigateToHomeTab()
                }
            }
        }
    }
    
    func callAppSettingApi(){
        let parameters = AppSettingParams(device_type: DeviceInfo.deviceType.rawValue, type: DeviceInfo.type.rawValue, device_token:kDeviceToken, device_unique_id:kDeviceUniqueId )
        HomeScreenServices().getAppSettings(parameters: parameters) { responce  in
            switch responce{
            case.success(let data):
                authKey = data.authKey
                SDWebImageManagerRevamp.shared.imageBaseUrl = data.imageBaseURL
                self.dispatchGroup.leave()               
                debugPrint("callAppSettingApi Done")
            case.failure(let error):
                debugPrint("callAppSettingApi falied")
                self.isApiCallFailed = true
                self.dispatchGroup.leave()
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func apiCallFailed(){
        dispatchGroup.leave()
    }
}
