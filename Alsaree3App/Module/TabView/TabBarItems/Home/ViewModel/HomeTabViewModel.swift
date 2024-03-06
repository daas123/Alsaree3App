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
        if Connectivity.checkNetAndLoc(){
            resetApiFectechedData()
            self.homeTabDeligate?.reloadTableView()
            dispatchGroup.enter()
            callAppSettingApi()
            dispatchGroup.notify(queue: .main) {
                self.callHomeScreenApis()
            }
        }else{
            apiCallFailed(isRemoveDispatchGroup: false,isApicallfailed: true)
        }
    }
    func reloadOnPull(){
        callFullHomeScreenApi()
    }
    
    func instantiateApiCalls(){
        if Connectivity.checkNetAndLoc(){
            isLoadingState = true
            isApiCallFailed = false
            print("Before callingHomeScreen")
            self.homeTabDeligate?.reloadTableView()
            callHomeScreenApis()
        }else{
            apiCallFailed(isRemoveDispatchGroup: false,isApicallfailed: true)
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
        currentPage = 1
        closeStorePage = 1
        isLoadingState = true
        isApiCallFailed = false
        isCallCloseStore = false
        isAllApiCallDone = false
    }
    
    func callHomeScreenStorelistNextPageApi(){
        if !isAllApiCallDone{
            if isCallCloseStore{
                if Connectivity.checkNetAndLoc(){
                    closeStorePage += 1
                    callHomeScreenGetCloseStoreListApi(pageNo:String(closeStorePage))
                }else{
                    isStoreApiFailed = true
                }
            }else{
                if Connectivity.checkNetAndLoc(){
                    currentPage += 1
                    callHomeScreenStoreListApi(pageNo: String(currentPage))
                }else{
                    isStoreApiFailed = true
                }
            }
        }
    }
    
    func callStoreApi(storeId : String){
        // some it comes empty store id
        if storeId == "" {
            print("store id is empty")
            return
        }
        print("store id is called \(storeId)")
    }
    
    func apiCallFailed(isRemoveDispatchGroup : Bool = true , isApicallfailed : Bool = false ,isStoreApiFailed : Bool = false){
        if isRemoveDispatchGroup{
            if !ReachabilityRevamp.isConnectedToNetwork() {
                NotificationManager().postNetworkStatusChanged()
            }else if !LocationManagerRevamp.shared.isLocationAccess {
                NotificationManager().postLocationAccessRestricted()
            }else{
                dispatchGroup.leave()
            }
            
        }
        
        if isApicallfailed{
            isApiCallFailed = true
            DispatchQueue.main.async {
                print("before getting the error")
                self.homeTabDeligate?.reloadTableView()
            }
        }
        
        if isStoreApiFailed{
            self.isStoreApiFailed = true
            currentPage -= 1
            self.homeTabDeligate?.reloadTableView()
        }
    }
}
