//
//  HomeTabViewDataSource.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import UIKit
extension HomeTabViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel.recentlyAddedStores == nil || viewModel.homeScreenStoreListData == nil) ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.getTableViewCount(Section: 0)
        }else{
            return viewModel.getTableViewCount(Section: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.recentlyAddedStores == nil || viewModel.homeScreenStoreListData == nil {
            if viewModel.isApiCallFailed{
                let loadingCell = tableView.getCell(identifier: CellConstant.loadingTableViewCell.rawValue) as! LoadingTableViewCell
                loadingCell.homeTabdeilgate = self
                loadingCell.showRetryButton()
                return loadingCell
            }else{
                let cell = tableView.getCell(identifier: CellConstant.homeTabShimmerCell.rawValue) as! HomeTabShimmerCell
                return cell
            }
        }
        
        if indexPath.section == 0 {
            
            switch indexPath.row{
            case 0 :
                if true{
                    let cell = tableView.getCell(identifier: CellConstant.activeOrderHomeTabCell.rawValue) as! ActiveOrderHomeTabCell
                    cell.selectionStyle = .none
                    return cell
                }else{
                    let cell = tableView.getCell(identifier: CellConstant.goldCategoryCardCellTableViewCell.rawValue) as! GoldCategoryCardCellTableViewCell
                    cell.selectionStyle = .none
                    return cell
                }
            case 1:
                let cell = tableView.getCell(identifier: CellConstant.bannerHomeTabCell.rawValue) as! BannerHomeTabCell
                cell.bannerData = viewModel.loyaltyDetail
                cell.selectionStyle = .none
                cell.setupUi()
                return cell
            default:
                return UITableViewCell()
            }
        }else{
            
            switch indexPath.row{
            case 0 :
                let cell = tableView.getCell(identifier: CellConstant.advertisementCell.rawValue) as! AdvertisementCell
                cell.advertisementBannerData = viewModel.banner
                cell.reloadData()
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.getCell(identifier: CellConstant.foodCatrgoryCell.rawValue) as! FoodCatrgoryCell
                cell.foodCategoryData = viewModel.tags
                cell.selectionStyle = .none
                return cell
            case 2:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.hometabDelegate = self
                cell.resturentTableViewCellData = viewModel.recentlyAddedStores
                cell.setText(StoreTitile: viewModel.recentlyAddedTitle ?? TextConstant.resturent.rawValue)
                cell.selectionStyle = .none
                return cell
            case 3:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.resturentTableViewCellData = viewModel.nearbyResturentStore
                cell.setText(StoreTitile: viewModel.nearbyResturentTitle ?? TextConstant.resturent.rawValue)
                cell.selectionStyle = .none
                return cell
            case 4:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.resturentTableViewCellData = viewModel.mostPopularStore
                cell.setText(StoreTitile: viewModel.mostPopularTitle ?? TextConstant.resturent.rawValue)
                cell.selectionStyle = .none
                return cell
            default:
                
                if let homeScreenStorelistCount = viewModel.homeScreenStoreListData?.count{
                    if homeScreenStorelistCount-2 == (indexPath.row - 5) {
                        viewModel.callHomeScreenStorelistNextPageApi()
                    }
                }
                
                let cell = tableView.getCell(identifier: CellConstant.resturentDetailsTableViewCell.rawValue) as! ResturentDetailsTableViewCell
                cell.resturentDetailsTableViewCellData = viewModel.homeScreenStoreListData?[indexPath.row - 5]
                cell.reloadCellData()
                cell.selectionStyle = .none
                return cell
            }
        }
        
    }
    
    
}
