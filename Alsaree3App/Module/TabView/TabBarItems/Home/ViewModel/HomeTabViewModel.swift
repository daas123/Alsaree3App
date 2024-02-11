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
    func setValueOfCurrentLocation(value:String)
    func reloadTableView()
}

class HomeTabViewModel{
    
    var activeOrder = false
    let dispatchGroup = DispatchGroup()
    // All APi Data
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
    var brands : [BrandsRevamp]?
    var tags : [TagsRevamp]?
    var banner : [BannerRevamp]?
    
    var homeScreenStoreListData : [Stores]?
    var pushZoneData : PushZoneModel?
    var homeTabDeligate : NavigateFormHomeTab?
    
    // MARK: paging count
    var currentPage = 1
    var closeStorePage = 1
    var isApiCallFailed = false
    var isCallCloseStore = false
    var isAllApiCallDone = false
    var isLoadingState = true
    var isStoreApiFailed = false
    
    var HomeTabData = [
        SectionAboveHeader.allCases,
        SectionBelowScrollingHeader.allCases
    ] as [Any]
    
    func getTableViewCount(Section:Int) -> Int{
        if Section == 0{
            if recentlyAddedStores == nil || homeScreenStoreListData == nil {
                return 2
            }
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
            self.isLoadingState = false
            self.homeTabDeligate?.reloadTableView()
        }
    }
    
    func callFullHomeScreenApi(){
        resetApiFectechedData()
        self.homeTabDeligate?.reloadTableView()
        dispatchGroup.enter()
        callAppSettingApi()
        dispatchGroup.notify(queue: .main) {
            self.callHomeScreenApis()
        }
    }
    func reloadOnPull(){
        resetApiFectechedData()
        dispatchGroup.enter()
        callLoyaltyDetailApi()
        dispatchGroup.enter()
        callHomeScreenMainDetailWithBannerImagesOffersApi()
        dispatchGroup.enter()
        callHomeScreenStoreListApi()
        dispatchGroup.notify(queue: .main) {
            self.homeTabDeligate?.reloadTableView()
        }
    }
    
    func instantiateApiCalls(){
        if LocationManagerRevamp.shared.isLocationAccess{
            self.homeTabDeligate?.reloadTableView()
            callHomeScreenApis()
        }else{
            homeTabDeligate?.showLocationAccessScreen()
        }
    }
    
    func resetApiFectechedData(){
        recentlyAddedStores = []
        mostPopularStore = []
        nearbyResturentStore = []
        brands = []
        tags = []
        banner = []
        homeScreenStoreListData = []
    }
    
    func callHomeScreenStorelistNextPageApi(){
        if !isAllApiCallDone{
            if isCallCloseStore{
                closeStorePage += 1
                callHomeScreenGetCloseStoreListApi(pageNo:String(closeStorePage))
            }else{
                currentPage += 1
                callHomeScreenStoreListApi(pageNo: String(currentPage))
            }
        }
    }
    
    func apiCallFailed(isRemoveDispatchGroup : Bool = true , isApicallfailed : Bool = false ,isStoreApiFailed : Bool = false){
        if isRemoveDispatchGroup{
            dispatchGroup.leave()
        }
        
        if isApicallfailed{
            isLoadingState = true
            isApiCallFailed = true
            DispatchQueue.main.async {
                self.homeTabDeligate?.reloadTableView()
            }
        }
        
        if isStoreApiFailed{
            self.isStoreApiFailed = true
        }
    }
}
