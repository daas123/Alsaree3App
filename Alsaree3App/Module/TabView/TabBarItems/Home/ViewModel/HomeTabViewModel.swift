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
}

class HomeTabViewModel{
    
    var activeOrder = false
    let operationQueue = OperationQueue()
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
    weak var homeTabDeligate : HomeTabViewController?
    
    // MARK: paging count
    var currentPage = 1
    var closeStorePage = 1
    var isApiCallFailed = false
    var isCallCloseStore = false
    
    var HomeTabData = [
        SectionAboveHeader.allCases,
        SectionBelowScrollingHeader.allCases
    ] as [Any]
    
    func getTableViewCount(Section:Int) -> Int{
        if Section == 0{
            if recentlyAddedStores == nil || homeScreenStoreListData == nil {
                return 1
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
        callAppSettingApi()
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
        callLoyaltyDetailApi()
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
    
    
    func callHomeScreenStorelistNextPageApi(){
        if isCallCloseStore{
            closeStorePage += 1
            callHomeScreenGetCloseStoreListApi(pageNo:String(closeStorePage))
        }else{
            currentPage += 1
            callHomeScreenStoreListApi(pageNo: String(currentPage))
        }
    }
    
    func apiCallFailed(isRemoveDispatchGroup : Bool = true){
        if isRemoveDispatchGroup{
            dispatchGroup.leave()
        }
        isApiCallFailed = true
    }
}
