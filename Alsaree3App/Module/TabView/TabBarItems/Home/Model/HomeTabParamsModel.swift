//
//  HomeTabParamsModel.swift
//  Alsaree3App
//
//  Created by Neosoft on 08/01/24.
//

import Foundation

struct AppSettingParams{
    let device_type : String
    let type : String
    let device_token : String
    let device_unique_id : String
}


struct CheckFeedBackParams{
    let user_id : String
    let server_token : String
}

struct LoyaltyDetailParams{
    let user_id : String
}

struct CartWithCampaignDiscountParams{
    let server_token : String
    let cart_unique_token : String
    let user_id : String
}

struct DeliveryListForNearestCityParams{
    let city3 : String
    let user_id : String
    let country : String
    let address : String
    let cart_unique_token : String
    let city2 : String
    let city1 : String
    let country_code_2 : String
    let city_code : String
    let country_code : String
    let latitude : String
    let server_token : String
    let longitude : String
}


// HomeScreenMainDetailWithBannerImagesOffersParams ,HomeScreenStoreListParams,HomeScreenGetCloseStoreList

struct HomeScreenStoreListParams{
    let city_id : String
    let page : String
    let longitude : String
    let cart_unique_token : String
    let store_delivery_id : String
    let user_id : String
    let latitude : String
    let language : String
    let server_token : String
}

struct PushZoneParams{
    let longitude : String
    let latitude : String
}


