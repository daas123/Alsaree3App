
import Foundation

typealias AnyDict = [String: Any]
typealias AnyDictString = [String: String]

var authKey : String = String()

let DEV_ROOT_POINT = "https://alsaree3service.com"
let PROD_ROOT_POINT = ""

let contentValue = "application/x-www-form-urlencoded"
let contentKey = "Content-Type"

enum NetworkEnvironment: String {
    case development
    case production
}

var networkEnvironment: NetworkEnvironment {
    return .development
}

var BaseURL: String {
    switch networkEnvironment {
    case .development :
        return DEV_ROOT_POINT
    case .production :
        return PROD_ROOT_POINT
    }
}


enum APIServices {
    
    case AppSettings(parameters: AnyDict)
    case CheckFeedBack(parameters: AnyDict)
    case LoyalityDetails(parameters: AnyDict)
    case CartWithCampaignDiscount(parameters: AnyDict)
    case DeliveryListForNearestCity(parameters: AnyDict)
    case HomeScreenMainDetailWithBannerImagesOffers(parameters: AnyDict)
    case HomeScreenStoreList(parameters: AnyDict)
    case Push_Zone(parameters: AnyDict)
    case HomeScreenGetCloseStoreList(parameters: AnyDict)
    case CountryList(parameters: AnyDict)
    
    //dummycase
    case get
}

extension APIServices {
    var Path: String {
        let apiDomain = "/api/Z381SQ4J6H/"
        var servicePath: String = ""
        switch self {
        case .AppSettings: servicePath = apiDomain + "admin/check_app_keys"
        case .CheckFeedBack: servicePath = apiDomain + "user/check_feedback"
        case .LoyalityDetails: servicePath = apiDomain + "user/get_loyalty_detail"
        case .CartWithCampaignDiscount : servicePath = apiDomain + "user/get_cart_with_campaign_discount_v1"
        case .DeliveryListForNearestCity : servicePath = apiDomain + "user/v2_get_delivery_list_for_nearest_city"
        case .HomeScreenMainDetailWithBannerImagesOffers : servicePath = apiDomain + "user/get_home_screen_main_detail_with_banner_images_offers"
        case .HomeScreenStoreList : servicePath = apiDomain + "user/get_home_screen_store_list"
        case .Push_Zone : servicePath = apiDomain + "user/get_push_zone"
        case .HomeScreenGetCloseStoreList : servicePath = apiDomain + "user/home_screen_get_close_store_list_new_version"
        case .CountryList : servicePath = apiDomain + "admin/get_country_list"
            //dummmy
        case .get: "dummy"
            
        }
        
        return BaseURL + servicePath
    }
    
    
    var parameters: AnyDict? {
        switch self {
        case .AppSettings(let param):
            return param
        case .CheckFeedBack(let param):
            return param
        case .LoyalityDetails(let param):
            return param
        case .CartWithCampaignDiscount(let param):
            return param
        case .DeliveryListForNearestCity(let param):
            return param
        case .HomeScreenMainDetailWithBannerImagesOffers(let param):
            return param
        case .HomeScreenStoreList(parameters: let param):
            return param
        case .Push_Zone(let param):
            return param
        case .HomeScreenGetCloseStoreList(parameters: let param):
            return param
        case .CountryList(let param):
            return param
        default:
            return nil
        }
    }
    
    //headers code
    var header: AnyDictString {
        return appSettingsHeader()
    }
    
    var httpMethod: String {
        switch self {
        case .get:
            return "GET"
        default:
            return "POST"
        }
    }
    
    private func appSettingsHeader() -> AnyDictString {
        var headerDict = AnyDictString()
        headerDict[contentKey] = contentValue
        var longitude: String = ""
        var latitude: String = ""
        
        if let currentLocation = LocationManagerRevamp.shared.currentLocation {
            longitude = String(describing: currentLocation.longitude)
            latitude = String(describing: currentLocation.latitude)
        }
        let app_version = "1.3.00"
        var auth_key = String()
        do {
            switch self{
            case .AppSettings:
                auth_key = try EncriptionManager().aesEncrypt(value: KeyConstant.authKey.rawValue, key: KeyConstant.key.rawValue, iv: KeyConstant.iv16.rawValue)
            case.CheckFeedBack,.LoyalityDetails,.CartWithCampaignDiscount,.DeliveryListForNearestCity,.HomeScreenMainDetailWithBannerImagesOffers,.HomeScreenStoreList,.Push_Zone,.HomeScreenGetCloseStoreList,.CountryList:
                auth_key = try EncriptionManager().aesEncrypt(value: authKey, key: KeyConstant.key2.rawValue, iv: KeyConstant.iv162.rawValue)
                //dummy
            case .get : break
                
            }
        } catch {
            debugPrint(error)
        }
        let device_type = "ios"
        let language = "en"
        headerDict = [
            contentKey: contentValue,
            "longitude": longitude ,
            "latitude": latitude ,
            "app_version": app_version,
            "auth_key": auth_key,
            "device_type": device_type,
            "language": language
        ]
        return headerDict
    }
    
}


