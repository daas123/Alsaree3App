//
//  HomeTabDeliveryListForNearestCityModel.swift
//  Alsaree3App
//
//  Created by Neosoft on 08/01/24.
//

import Foundation

struct DeliveryListForNearestCityModel: Codable {
    let success: Bool
    let serverTime, country, countryCode, currencySign: String
    let city: CityRevamp
    let deliveries: [DeliveryRevamp]
    let cityData: CityDataRevamp

    enum CodingKeys: String, CodingKey {
        case success
        case serverTime = "server_time"
        case country
        case countryCode = "country_code"
        case currencySign = "currency_sign"
        case city, deliveries
        case cityData = "city_data"
    }
}

// City
struct CityRevamp: Codable {
    let isOtherPaymentMode, isCashPaymentMode: Bool
    let id: String
    let uniqueID: Int
    let updatedAt, createdAt, countryID, cityName: String
    let cityCode, timezone: String

    enum CodingKeys: String, CodingKey {
        case isOtherPaymentMode = "is_other_payment_mode"
        case isCashPaymentMode = "is_cash_payment_mode"
        case id = "_id"
        case uniqueID = "unique_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case countryID = "country_id"
        case cityName = "city_name"
        case cityCode = "city_code"
        case timezone
    }
}

// CityData
struct CityDataRevamp: Codable {
    let userID, serverToken, cartUniqueToken, country: String
    let countryCode, countryCode2, cityCode, latitude: String
    let longitude, city1, city2, city3: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case serverToken = "server_token"
        case cartUniqueToken = "cart_unique_token"
        case country
        case countryCode = "country_code"
        case countryCode2 = "country_code_2"
        case cityCode = "city_code"
        case latitude, longitude, city1, city2, city3
    }
}

//  Delivery
struct DeliveryRevamp: Codable {
    let id, mapPinURL, iconURL, imageURL: String
    let deliveryName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case mapPinURL = "map_pin_url"
        case iconURL = "icon_url"
        case imageURL = "image_url"
        case deliveryName = "delivery_name"
    }
}
