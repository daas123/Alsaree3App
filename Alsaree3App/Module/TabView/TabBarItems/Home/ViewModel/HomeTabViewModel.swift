//
//  HomeTabViewModel.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//



import Foundation
import UIKit
//main enum

class HomeTabViewModel{
    
    var activeOrder = false
    let dispatchGroup = DispatchGroup()
    //MARK: Data for home tab
    var checkFeedBackData : CheckFeedBackModel?
    var loyaltyDetail : LoyaltyDetailsModel?
    var deliveryListForNearestCityData : DeliveryListForNearestCityModel?
    var recentlyAddedStores : [Stores]?
    var mostPopularStore : [Stores]?
    var nearbyResturentStore : [Stores]?
    var brands : [BrandsRevamp]?
    var tags : [TagsRevamp]?
    var banner : [BannerRevamp]?
    var homeScreenStoreListData : [Stores]?
    var pushZoneData : PushZoneModel?
    
    var recentlyAddedTitle : String?
    var mostPopularTitle : String?
    var nearbyResturentTitle : String?
    
    var homeTabDeligate : NavigateFormHomeTab?
    
    // MARK: Appstate
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
        callFeedBackApi()
        callLoyaltyDetailApi()
        callDeliveryListForNearestCityApi()
        dispatchGroup.wait()
        callHomeScreenMainDetailWithBannerImagesOffersApi()
        callHomeScreenStoreListApi()
        callPushZoneApi()
        dispatchGroup.notify(queue: .main) {
            self.isLoadingState = false
            self.homeTabDeligate?.reloadTableView()
        }
    }
    
    func callFullHomeScreenApi(){
        if Connectivity.checkNetAndLoc(){
            resetApiFectechedData()
            isLoadingState = true
            isApiCallFailed = false
            self.homeTabDeligate?.reloadTableView()
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
            self.homeTabDeligate?.reloadTableView()
            callHomeScreenApis()
        }else{
            apiCallFailed(isRemoveDispatchGroup: false,isApicallfailed: true)
        }
    }
    
    func resetApiFectechedData(){
        currentPage = 1
                closeStorePage = 1
                isLoadingState = true
                isApiCallFailed = false
                isCallCloseStore = false
                isAllApiCallDone = false
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
    
    func callBannerApi(){
        callLoyaltyDetailApi()
        dispatchGroup.notify(queue: .main) {
            self.homeTabDeligate?.reloadTableView()
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
    
    func apiCallFailed(isRemoveDispatchGroup : Bool = true , isApicallfailed : Bool = false ,isStoreApiFailed : Bool = false,isClosestoreApiFailed:Bool = false){
        if isRemoveDispatchGroup{
            if !ReachabilityRevamp.isConnectedToNetwork() {
                NotificationManager().postNetworkStatusChanged()
            }else if !LocationManagerRevamp.shared.isLocationAccess {
                NotificationManager().postLocationAccessRestricted()
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
        
        if isClosestoreApiFailed{
            self.isStoreApiFailed = true
            closeStorePage -= 1
            self.homeTabDeligate?.reloadTableView()
        }
    }
}
