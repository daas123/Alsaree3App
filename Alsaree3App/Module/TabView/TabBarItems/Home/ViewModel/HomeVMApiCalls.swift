//
//  HomeVMApiCalls.swift
//  Alsaree3App
//
//  Created by Neosoft on 16/01/24.
//

import Foundation
extension HomeTabViewModel{
    
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
                self.apiCallFailed()
                debugPrint(error.localizedDescription)
            }
            
        }
    }
    
    func callFeedBackApi(){
        let parameter = CheckFeedBackParams(user_id: kUserId, server_token: kServerToken)
        HomeScreenServices().getFeedBackResponce(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callFeedBackApi Done")
                self.checkFeedBackData = data
                self.dispatchGroup.leave()
            case .failure(let error):
                self.apiCallFailed()
                debugPrint("callFeedBackApi failed")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func callLoyaltyDetailApi(){
        let parameter = LoyaltyDetailParams(user_id: kUserId)
        HomeScreenServices().getLoyaltyDetail(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callLoyaltyDetailApi Done")
                self.loyaltyDetail = data
                self.dispatchGroup.leave()
            case .failure(let error):
                self.apiCallFailed()
                debugPrint("callLoyaltyDetailApi failed")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func callDeliveryListForNearestCityApi(){
        let parameter = DeliveryListForNearestCityParams(
            city3: kCity3,
            user_id: kUserId,
            country: kCountry,
            address: kAddress,
            cart_unique_token: kCartUniqueToken,
            city2: kCity2,
            city1: kCity1,
            country_code_2: kCountryCode2,
            city_code: kCityCode,
            country_code: kCountryCode,
            latitude: String(describing: LocationManagerRevamp.shared.currentLocation?.latitude ?? 0),
            server_token: kServerToken,
            longitude: String(describing: LocationManagerRevamp.shared.currentLocation?.longitude ?? 0)
        )
        HomeScreenServices().getDeliveryListForNearestCity(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callDeliveryListForNearestCityApi Done")
                self.dispatchGroup.leave()
                kCityId = data.city.id
                kStoreDeliveryId = data.deliveries[0].id
                self.homeTabDeligate?.setValueOfCurrentLocation(value: data.city.cityCode)
                self.deliveryListForNearestCityData = data
            case .failure(let error):
                debugPrint("callDeliveryListForNearestCityApi failed")
                self.apiCallFailed(isApicallfailed: true)
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    //error Calling the data
    func callHomeScreenMainDetailWithBannerImagesOffersApi(){
        let parameter = HomeScreenStoreListParams(
            city_id: kCityId,
            page: "1",
            longitude: String(describing: LocationManagerRevamp.shared.currentLocation?.longitude ?? 0),
            cart_unique_token: kCartUniqueToken,
            store_delivery_id: kStoreDeliveryId,
//            store_delivery_id: "",
            user_id: kUserId,
            latitude: String(describing: LocationManagerRevamp.shared.currentLocation?.latitude ?? 0),
            language:  DeviceInfo.englishLang.rawValue,
            server_token: kServerToken
        )
        
        HomeScreenServices().getHomeScreenMainDetailWithBannerImagesOffers(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callHomeScreenMainDetailWithBannerImagesOffersApi Done")
                self.isApiCallFailed = false
                self.recentlyAddedTitle = data.horizontal_store_title
                self.mostPopularTitle = data.ads_title
                self.nearbyResturentTitle = data.store_listing_title
                self.recentlyAddedStores = data.horizontal_stores
                self.mostPopularStore = data.horizontal_stores_2
                self.nearbyResturentStore = data.store_offers
                self.brands = data.brands
                self.tags = data.tags
                self.banner = data.banner
                self.dispatchGroup.leave()
            case .failure(let error):
                debugPrint("callHomeScreenMainDetailWithBannerImagesOffersApi failed")
                self.apiCallFailed(isApicallfailed: true)
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func callHomeScreenStoreListApi(pageNo:String = "1"){
        let parameter = HomeScreenStoreListParams(
            city_id: kCityId,
            page: pageNo,
            longitude: String(describing: LocationManagerRevamp.shared.currentLocation?.longitude ?? 0),
            cart_unique_token: kCartUniqueToken,
            store_delivery_id: kStoreDeliveryId,
            user_id: kUserId,
            latitude: String(describing: LocationManagerRevamp.shared.currentLocation?.latitude ?? 0),
            language:  DeviceInfo.englishLang.rawValue,
            server_token: kServerToken
            
        )
        HomeScreenServices().getHomeScreenStoreList(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callHomeScreenStoreListApi Done")
                if let storeData = data.stores{
                    if self.homeScreenStoreListData == nil {
                        self.homeScreenStoreListData = []
                    }
                    self.homeScreenStoreListData! += storeData
                }
                
                if (data.message == nil || data.success == false){
                    self.isCallCloseStore = true
                    self.callHomeScreenGetCloseStoreListApi()
                }

                if pageNo == "1"{
                    self.dispatchGroup.leave()
                }else{
                    DispatchQueue.main.async {
                        self.isStoreApiFailed = false
                        self.homeTabDeligate?.reloadTableView()
                    }
                }
            case .failure(let error):
                self.apiCallFailed(isStoreApiFailed: true)
                debugPrint("callHomeScreenStoreListApi failed")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func callPushZoneApi(){
        let parameter = PushZoneParams(
            longitude:String(describing: LocationManagerRevamp.shared.currentLocation?.longitude ?? 0),
            latitude: String(describing: LocationManagerRevamp.shared.currentLocation?.latitude ?? 0))
        HomeScreenServices().getPushZoneData(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callPushZoneApi Done")
                self.pushZoneData = data
                self.dispatchGroup.leave()
            case .failure(let error):
                self.apiCallFailed()
                debugPrint("callPushZoneApi failed")
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func callHomeScreenGetCloseStoreListApi(pageNo:String = "1"){
        let parameter = HomeScreenStoreListParams(
            city_id: kCityId,
            page: pageNo,
            longitude: String(describing: LocationManagerRevamp.shared.currentLocation?.longitude ?? 0),
            cart_unique_token: kCartUniqueToken,
            store_delivery_id: kStoreDeliveryId,
            user_id: kUserId,
            latitude: String(describing: LocationManagerRevamp.shared.currentLocation?.latitude ?? 0),
            language:  DeviceInfo.englishLang.rawValue,
            server_token: kServerToken
        )
        
        HomeScreenServices().getHomeScreenGetCloseStoreListData(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                debugPrint("callHomeScreenGetCloseStoreListApi Done")
                if let storeData = data.stores{
                    if self.homeScreenStoreListData == nil {
                        self.homeScreenStoreListData = []
                    }
                        self.homeScreenStoreListData! += storeData
                }else{
                    self.isAllApiCallDone = true
                }
                DispatchQueue.main.async {
                    self.isStoreApiFailed = false
                    self.homeTabDeligate?.reloadTableView()
                }
            case .failure(let error):
                self.apiCallFailed(isStoreApiFailed: true)
                debugPrint("callHomeScreenGetCloseStoreListApi failed")
                debugPrint(error.localizedDescription)
            }
        }
        
    }
}
