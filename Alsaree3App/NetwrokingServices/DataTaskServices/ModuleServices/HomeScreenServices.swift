//
//  HomeScreenServices.swift
//  Alsaree3App
//
//  Created by Neosoft on 05/01/24.
//

import Foundation
class HomeScreenServices{
    
    //provide the basic details of application setup
    func getAppSettings(parameters:AppSettingParams, completion: @escaping (Result<AppSettingModel, APIError>) -> Void){
        let param:[String : Any] = ["device_token":parameters.device_token,
                                    "device_unique_id":parameters.device_unique_id,
                                    "device_type":parameters.device_type,
                                    "type":parameters.type]
        APIManager.sharedInstance.performRequest(serviceType: .AppSettings(parameters: param)) { response in
            switch response {
            case .success(let responseData):
                
                if let decodedResponseData = try? JSONDecoder().decode(AppSettingModel.self, from: responseData) {
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }
                
            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    // Check Weaher the FeedBack PopUp should appear or not
    func getFeedBackResponce(parameters:CheckFeedBackParams, completion: @escaping (Result<CheckFeedBackModel, APIError>) -> Void){
        let param:[String : Any] = ["user_id":parameters.user_id,
                                    "server_token":parameters.server_token]
        
        APIManager.sharedInstance.performRequest(serviceType: .CheckFeedBack(parameters: param)) { response in
            switch response{
            case .success(let responseData):
                
                if let decodedResponseData = try? JSONDecoder().decode(CheckFeedBackModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }
                
            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    // Get the loyality points And Other details
    func getLoyaltyDetail(parameters:LoyaltyDetailParams, completion: @escaping (Result<LoyaltyDetailsModel, APIError>) -> Void){
        let param:[String : Any] = ["user_id":parameters.user_id]

        APIManager.sharedInstance.performRequest(serviceType: .LoyalityDetails(parameters: param)) { response in
            switch response{
            case .success(let responseData):

                if let decodedResponseData = try? JSONDecoder().decode(LoyaltyDetailsModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getDeliveryListForNearestCity(parameters:DeliveryListForNearestCityParams, completion: @escaping (Result<DeliveryListForNearestCityModel, APIError>) -> Void){
        let param:[String : Any] = ["city3":parameters.city3,
                                    "user_id":parameters.user_id,
                                    "country":parameters.country,
                                    "address":parameters.address,
                                    "cart_unique_token":parameters.cart_unique_token,
                                    "city2":parameters.city2,
                                    "city1":parameters.city1,
                                    "country_code_2":parameters.country_code_2,
                                    "city_code":parameters.city_code,
                                    "country_code":parameters.country_code,
                                    "latitude":parameters.latitude,
                                    "server_token":parameters.server_token,
                                    "longitude":parameters.longitude]

        APIManager.sharedInstance.performRequest(serviceType: .DeliveryListForNearestCity(parameters: param)) { response in
            switch response{
            case .success(let responseData):
                if let decodedResponseData = try? JSONDecoder().decode(DeliveryListForNearestCityModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getHomeScreenMainDetailWithBannerImagesOffers(parameters:HomeScreenStoreListParams, completion: @escaping (Result<HomeScreenMainDetailWithBannerImagesOffersModel, APIError>) -> Void){
        let param:[String : Any] = ["latitude":parameters.latitude,
                                    "longitude":parameters.longitude,
                                    "language":parameters.language,
                                    "page":parameters.page,
                                    "store_delivery_id":parameters.store_delivery_id,
                                    "city_id":parameters.city_id,
                                    "user_id":parameters.user_id,
                                    "server_token":parameters.server_token,
                                    "cart_unique_token":parameters.cart_unique_token]

        APIManager.sharedInstance.performRequest(serviceType: .HomeScreenMainDetailWithBannerImagesOffers(parameters: param)) { response in
            switch response{
            case .success(let responseData):

                if let decodedResponseData = try? JSONDecoder().decode(HomeScreenMainDetailWithBannerImagesOffersModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getHomeScreenStoreList(parameters:HomeScreenStoreListParams, completion: @escaping (Result<StoreListModel, APIError>) -> Void){
        let param:[String : Any] = ["city_id":parameters.city_id,
                                    "page":parameters.page,
                                    "longitude":parameters.longitude,
                                    "cart_unique_token":parameters.cart_unique_token,
                                    "store_delivery_id":parameters.store_delivery_id,
                                    "user_id":parameters.user_id,
                                    "latitude":parameters.latitude,
                                    "language":parameters.language,
                                    "server_token":parameters.server_token]

        APIManager.sharedInstance.performRequest(serviceType: .HomeScreenStoreList(parameters: param)) { response in
            switch response{
            case .success(let responseData):

                if let decodedResponseData = try? JSONDecoder().decode(StoreListModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getPushZoneData(parameters:PushZoneParams, completion: @escaping (Result<PushZoneModel, APIError>) -> Void){
        let param:AnyDictString = ["latitude":parameters.latitude,
                                   "longitude":parameters.longitude]

        APIManager.sharedInstance.performRequest(serviceType: .Push_Zone(parameters: param)) { response in
            switch response{
            case .success(let responseData):

                if let decodedResponseData = try? JSONDecoder().decode(PushZoneModel.self, from: responseData){
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    func getHomeScreenGetCloseStoreListData(parameters:HomeScreenStoreListParams, completion: @escaping (Result<StoreListModel, APIError>) -> Void){
        let param:[String : Any] = ["city_id":parameters.city_id,
                                    "page":parameters.page,
                                    "longitude":parameters.longitude,
                                    "cart_unique_token":parameters.cart_unique_token,
                                    "store_delivery_id":parameters.store_delivery_id,
                                    "user_id":parameters.user_id,
                                    "latitude":parameters.latitude,
                                    "language":parameters.language,
                                    "server_token":parameters.server_token]

        APIManager.sharedInstance.performRequest(serviceType: .HomeScreenGetCloseStoreList(parameters: param)) { response in
            switch response{
            case .success(let responseData):
                if let decodedResponseData = try? JSONDecoder().decode(StoreListModel.self, from: responseData){
//                    if let responceStore = decodedResponseData.stores{
//                        for Store in responceStore{
////                            Store.is_StoreClosed = true
//                        }
//                    }
                    completion(.success((decodedResponseData)))
                } else if let apiError = try? JSONDecoder().decode(ApiErrorModel.self, from: responseData) {
                    completion(.failure(.apiError(success: apiError.success, errorCode: apiError.error_code)))
                } else {
                    completion(.failure(.decodingError))
                }

            case .failure(_):
                completion(.failure(.decodingError))
            }
        }
    }
    
    
    
}
