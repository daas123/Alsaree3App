//
//  HomeTabApiErrorModel.swift
//  Alsaree3App
//
//  Created by Neosoft on 09/01/24.
//

import Foundation
struct ApiErrorModel:Codable{
    let success : Bool
    let error_code : Int
}


enum APIError: Error {
    case decodingError
    case apiError(success: Bool, errorCode: Int)
}

protocol HomeTableviewStoresAction {
    func callStoreApi(storeId: String)
    func seeMoreBtnNavigation()
}

protocol HomeTblCollViewAction{
    func animateResturentCell(Indexpath:IndexPath)
}

protocol NavigateFormHomeTab{
    func showLocationAccessScreen()
    func setValueOfCurrentLocation(value:String)
    func reloadTableView()
}
