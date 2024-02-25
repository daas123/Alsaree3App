//
//  HomeTabViewDeligate.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import UIKit
extension HomeTabViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animateCellSelection(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.isApiCallFailed || viewModel.isLoadingState{
            return tableView.bounds.height
        }

        let screenHeight = UIScreen.main.bounds.height
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return viewModel.activeOrder ? UITableView.automaticDimension : 0
        case (1,0):
            guard !((viewModel.banner?.isEmpty ?? true) || (viewModel.banner == nil)) else{
                return 0
            }
            if screenHeight > 900 {
                return tableView.bounds.height*0.36
            } else if screenHeight > 700 {
                return tableView.bounds.height*0.36
            } else {
                return tableView.bounds.height*0.45
            }
        case (1,1):
            guard !((viewModel.tags?.isEmpty ?? true) || (viewModel.tags == nil)) else{
                return 0
            }
            if screenHeight > 900 {
                return tableView.bounds.height*0.155
            } else if screenHeight > 700 {
                return tableView.bounds.height*0.155
            } else {
                return tableView.bounds.height*0.18
            }
        case (1, 2):
            guard !((viewModel.recentlyAddedStores?.isEmpty ?? true) || viewModel.recentlyAddedStores == nil) else{
                return 0
            }
            return heightForStore(screenHeight: screenHeight, store: viewModel.recentlyAddedStores, tableView: hometabTableView)
        case (1, 3):
            guard !((viewModel.nearbyResturentStore?.isEmpty ?? true) || viewModel.nearbyResturentStore == nil) else{
                return 0
            }
            return heightForStore(screenHeight: screenHeight, store: viewModel.nearbyResturentStore, tableView: hometabTableView)
        case (1, 4):
            guard !((viewModel.mostPopularStore?.isEmpty ?? true) || viewModel.mostPopularStore == nil) else{
                return 0
            }
            return heightForStore(screenHeight: screenHeight, store: viewModel.mostPopularStore, tableView: hometabTableView)
        case (2,0):
            guard !((viewModel.mostPopularStore?.isEmpty ?? true) || viewModel.mostPopularStore == nil || viewModel.isAllApiCallDone) else{
                return 0
            }
//            if viewModel.isAllApiCallDone{
//                return 0
//            }
            
            return heightForStore(screenHeight: screenHeight, store: viewModel.mostPopularStore, tableView: hometabTableView)
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
        case 1:
            headerView = Bundle.main.loadNibNamed(nibNamesConstant.homeTabCategoryHeader.rawValue, owner: self, options: nil)?.first as? HomeTabCategoryHeader
            headerView?.selectedTag = 1
            return headerView
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if viewModel.isApiCallFailed || viewModel.isLoadingState{
            return 0
        }
        
        if viewModel.recentlyAddedStores == nil && viewModel.homeScreenStoreListData == nil {
            return 0
        }
        if section == 0 || section == 2{
            return 0
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func heightForStore(screenHeight: CGFloat, store: [Stores]?,tableView:UITableView) -> CGFloat {
        guard !((store?.isEmpty ?? true) || store == nil) else{
            return 0
        }
        if screenHeight > 900 {
            return tableView.bounds.height*0.48
        } else if screenHeight > 700 {
            return tableView.bounds.height*0.52
        } else {
            return tableView.bounds.height*0.65
        }
    }
    
}

extension HomeTabViewController:NavigateFormHomeTab{

    func reloadTableView() {
        DispatchQueue.main.async {
            self.hometabTableView.reloadData()
            self.hometabTableView.layoutIfNeeded()
            self.setupSteckyHeader(self.hometabTableView)
        }
    }
    
    func setValueOfCurrentLocation(value: String) {
        DispatchQueue.main.async{
            ShimmeringView().stopShining(self.locationLbl)
            self.locationLbl.text = value
        }
    }
    
    
    func seeMoreBtnNavigation() {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: ViewControllerConstant.restaurantDetailsVC.rawValue) as! RestaurantDetailsVC
        // extra function
        viewModel.activeOrder = true
        newViewController.hidesBottomBarWhenPushed = true
        //        navigationController?.pushViewController(newViewController, animated: true)
        showLocationAccessScreen()
    }
    
    func showLocationAccessScreen() {
        LocationManagerRevamp.shared.requestLocationPermission { islocationAccess in
            if !islocationAccess{
                let storyboard = UIStoryboard(name: nibNamesConstant.commonScreens.rawValue, bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerConstant.locationAccessViewController.rawValue) as! LocationAccessViewController
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}


