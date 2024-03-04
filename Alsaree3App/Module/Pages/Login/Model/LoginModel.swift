//
//  LoginModel.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/02/24.
//

import Foundation

protocol LoginCellAlignment{
    func addReferalCodecell()
}

protocol updateProceedbtnState{
    func updateProceedBtn(isActive:Bool)
}

protocol viewModelActions{
    func reloadLoginTableView()
}

protocol MobileNoDelegate{
    func showCountryPickerview()
}

// MARK: - CountryList
struct CountryList: Codable {
    let success: Bool
    let message: Int
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let id: String
    let uniqueID: Int
    let updatedAt, createdAt: String
    let maximumPhoneNumberLength, minimumPhoneNumberLength: Int
    let isReferralProvider, isReferralStore, isReferralUser, isDistanceUnitMile: Bool
    let isBusiness: Bool
    let noOfProviderUseReferral, referralBonusToProviderFriend, referralBonusToProvider, noOfStoreUseReferral: JSONNull?
    let referralBonusToStoreFriend, referralBonusToStore: JSONNull?
    let noOfUserUseReferral, referralBonusToUserFriend, referralBonusToUser: Int
    let isAdsVisible: Bool
    let countryCode2, countryPhoneCode, currencySign, currencyCode: String
    let currencyName: String
    let countryTimezone: [String]
    let countryCode, countryFlag, countryName: String
    let currencyRate: Double
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case uniqueID = "unique_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case maximumPhoneNumberLength = "maximum_phone_number_length"
        case minimumPhoneNumberLength = "minimum_phone_number_length"
        case isReferralProvider = "is_referral_provider"
        case isReferralStore = "is_referral_store"
        case isReferralUser = "is_referral_user"
        case isDistanceUnitMile = "is_distance_unit_mile"
        case isBusiness = "is_business"
        case noOfProviderUseReferral = "no_of_provider_use_referral"
        case referralBonusToProviderFriend = "referral_bonus_to_provider_friend"
        case referralBonusToProvider = "referral_bonus_to_provider"
        case noOfStoreUseReferral = "no_of_store_use_referral"
        case referralBonusToStoreFriend = "referral_bonus_to_store_friend"
        case referralBonusToStore = "referral_bonus_to_store"
        case noOfUserUseReferral = "no_of_user_use_referral"
        case referralBonusToUserFriend = "referral_bonus_to_user_friend"
        case referralBonusToUser = "referral_bonus_to_user"
        case isAdsVisible = "is_ads_visible"
        case countryCode2 = "country_code_2"
        case countryPhoneCode = "country_phone_code"
        case currencySign = "currency_sign"
        case currencyCode = "currency_code"
        case currencyName = "currency_name"
        case countryTimezone = "country_timezone"
        case countryCode = "country_code"
        case countryFlag = "country_flag"
        case countryName = "country_name"
        case currencyRate = "currency_rate"
        case v = "__v"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
