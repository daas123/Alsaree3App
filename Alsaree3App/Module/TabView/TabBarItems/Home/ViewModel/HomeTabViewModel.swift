//
//  HomeTabViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//



import Foundation
import UIKit
//main enum
protocol NavigateFormHomeTab{
    func seeMoreBtnNavigation()
    func showLocationAccessScreen()
}

class HomeTabViewModel{
    
    var activeOrder = false
    var isAppsettingApiFailed = true
    var isHomeScreenStoreListDataFailed = true
    var isDeliveryListForNearestCityApiFailed = true
    var isHomeScreenStoreListApiFailed = true
    
    let dispatchGroup = DispatchGroup()
    // All APi Data
    var appSettingData : AppSettingModel?
    var checkFeedBackData : CheckFeedBackModel?
    var loyaltyDetail : LoyaltyDetailsModel?
    var deliveryListForNearestCityData : DeliveryListForNearestCityModel?
    //MARK: Data for home tab
    var recentlyAddedTitle : String?
    var mostPopularTitle : String?
    var nearbyResturentTitle : String?
    
    var recentlyAddedStores : [Stores]?
    var mostPopularStore : [Stores]?
    var nearbyResturentStore : [Stores]?
    var brands : [Brands]?
    var tags : [Tags]?
    var banner : [Banner]?
    
    var homeScreenStoreListData : [Stores]?
    var pushZoneData : PushZoneModel?
    var homeTabDeligate : HomeTabViewController?
    
    
    var HomeTabData = [
        SectionAboveHeader.allCases,
        SectionBelowScrollingHeader.allCases
    ] as [Any]
    
    func getTableViewCount(Section:Int = 0) -> Int{
        if homeScreenStoreListData == nil || recentlyAddedStores == nil {
            return 1
        }else if Section == 0{
            return SectionAboveHeader.allCases.count
        }else if Section == 1{
            return (SectionBelowScrollingHeader.allCases.count + ((homeScreenStoreListData?.count ?? 0)-1))
        }
        else{
            return 1
        }
    }
    
    func callHomeScreenApis(){
        dispatchGroup.enter()
        callApi()
        dispatchGroup.wait()
        dispatchGroup.enter()
        callFeedBackApi()
        dispatchGroup.enter()
        callLoyaltyDetailApi()
        dispatchGroup.enter()
        callDeliveryListForNearestCityApi()
        dispatchGroup.wait()
        dispatchGroup.enter()
        callHomeScreenMainDetailWithBannerImagesOffersApi()
        dispatchGroup.enter()
        callHomeScreenStoreListApi()
        dispatchGroup.enter()
        callPushZoneApi()
        dispatchGroup.notify(queue: .main) {
            self.homeTabDeligate?.hometabTableView.reloadData()
        }
    }

    func reloadOnPull(){
        dispatchGroup.enter()
        callHomeScreenMainDetailWithBannerImagesOffersApi()
        dispatchGroup.enter()
        callHomeScreenStoreListApi()
        dispatchGroup.notify(queue: .main) {
            self.homeTabDeligate?.hometabTableView.reloadData()
        }
    }
    
    func checkLocationAccess(){
        if LocationManager.shared.isLocationAccess{
            homeTabDeligate?.isLoadingState = true
            homeTabDeligate?.hometabTableView.reloadData()
            callHomeScreenApis()
        }else{
            homeTabDeligate?.showLocationAccessScreen()
        }
    }
    
    
}
