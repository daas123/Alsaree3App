//
//  HomeVMApiCalls.swift
//  Alsaree3App
//
//  Created by Neosoft on 16/01/24.
//

import Foundation
extension HomeTabViewModel{
    func callApi(){
        let parameters = AppSettingParams(device_type: DeviceInfo.deviceType.rawValue, type: DeviceInfo.type.rawValue, device_token:kDeviceToken, device_unique_id:kDeviceUniqueId )
        HomeScreenServices().getAppSettings(parameters: parameters) { responce  in
            switch responce{
            case.success(let data):
                authKey = data.authKey
                SDWebImageManager.shared.imageBaseUrl = data.imageBaseURL
                self.dispatchGroup.leave()
                print("AppSetting done")
            case.failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    func callFeedBackApi(){
        let parameter = CheckFeedBackParams(user_id: kUserId, server_token: kServerToken)
        HomeScreenServices().getFeedBackResponce(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                print(data)
                self.dispatchGroup.leave()
                self.checkFeedBackData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callLoyaltyDetailApi(){
        let parameter = LoyaltyDetailParams(user_id: kUserId)
        HomeScreenServices().getLoyaltyDetail(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                print(data)
                self.dispatchGroup.leave()
                self.loyaltyDetail = data
            case .failure(let error):
                print(error.localizedDescription)
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
            latitude: String(describing: LocationManager.shared.currentLocation?.latitude ?? 0),
            server_token: kServerToken,
            longitude: String(describing: LocationManager.shared.currentLocation?.longitude ?? 0)
        )
        HomeScreenServices().getDeliveryListForNearestCity(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                print(data)
                self.dispatchGroup.leave()
                kCityId = data.city.id
                kStoreDeliveryId = data.deliveries[0].id
                self.deliveryListForNearestCityData = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //error Calling the data
    func callHomeScreenMainDetailWithBannerImagesOffersApi(){
        let parameter = HomeScreenMainDetailWithBannerImagesOffersParams(
            latitude: String(describing: LocationManager.shared.currentLocation?.latitude ?? 0),
            longitude: String(describing: LocationManager.shared.currentLocation?.longitude ?? 0),
            language: DeviceInfo.englishLang.rawValue,
            page: "1",
            store_delivery_id: kStoreDeliveryId,
            city_id: kCityId,
            user_id: kUserId,
            server_token: kServerToken,
            cart_unique_token: kCartUniqueToken
        )
        HomeScreenServices().getHomeScreenMainDetailWithBannerImagesOffers(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
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
                print(error.localizedDescription)
            }
        }
    }
    
    func callHomeScreenStoreListApi(){
        let parameter = HomeScreenStoreListParams(
            city_id: kCityId,
            page: "1",
            longitude: String(describing: LocationManager.shared.currentLocation?.longitude ?? 0) ,
            cart_unique_token: kCartUniqueToken,
            store_delivery_id: kStoreDeliveryId,
            user_id: kUserId,
            latitude: String(describing: LocationManager.shared.currentLocation?.latitude ?? 0),
            language: DeviceInfo.englishLang.rawValue,
            server_token: kServerToken)
        HomeScreenServices().getHomeScreenStoreList(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                print(data)
                self.homeScreenStoreListData = data.stores
                self.dispatchGroup.leave()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func callPushZoneApi(){
        let parameter = PushZoneParams(
            longitude:String(describing: LocationManager.shared.currentLocation?.longitude ?? 0),
            latitude: String(describing: LocationManager.shared.currentLocation?.latitude ?? 0))
        HomeScreenServices().getPushZoneData(parameters: parameter) { responce in
            switch responce{
            case .success(let data):
                print(data)
                self.pushZoneData = data
                self.dispatchGroup.leave()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}