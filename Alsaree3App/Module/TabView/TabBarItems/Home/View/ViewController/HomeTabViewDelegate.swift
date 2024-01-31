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
        if viewModel.recentlyAddedStores == nil && viewModel.homeScreenStoreListData == nil {
            return tableView.bounds.height
        }
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            return viewModel.activeOrder ? UITableView.automaticDimension : 0
        case (1, 2):
            return viewModel.recentlyAddedStores == nil ? 0 : UITableView.automaticDimension
        case (1, 3):
            return viewModel.nearbyResturentStore == nil ? 0 : UITableView.automaticDimension
        case (1, 4):
            return viewModel.mostPopularStore == nil ? 0 : UITableView.automaticDimension
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
        case 1:
            headerView = Bundle.main.loadNibNamed(nibNamesConstant.homeTabCategoryHeader.rawValue, owner: self, options: nil)?.first as? HomeTabCategoryHeader
            return headerView
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewModel.recentlyAddedStores == nil && viewModel.homeScreenStoreListData == nil {
            return 0
        }
        if section == 0{
            return 0
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        hometabTableView.bounds.height*0.7
    }
    
}

extension HomeTabViewController:NavigateFormHomeTab{

    func reloadTableView() {
        self.hometabTableView.reloadData()
        self.hometabTableView.layoutIfNeeded()
        self.setupSteckyHeader(hometabTableView)
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


