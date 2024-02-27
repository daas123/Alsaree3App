//
//  HomeTabViewDataSource.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import UIKit
extension HomeTabViewController:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel.isLoadingState || viewModel.isApiCallFailed) ? 1 : 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isLoadingState || viewModel.isApiCallFailed{
            return 1
        }
        
        if section == 0{
            return viewModel.getTableViewCount(Section: 0)
        }else if section == 1{
            return viewModel.getTableViewCount(Section: 1)
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isApiCallFailed{
            let loadingCell = tableView.getCell(identifier: CellConstant.loadingTableViewCell.rawValue) as! LoadingTableViewCell
            loadingCell.homeTabdeilgate = self
            backButton.isHidden = true
            loadingCell.showRetryButton()
            return loadingCell
        }
        
        if viewModel.isLoadingState {
            let cell = tableView.getCell(identifier: CellConstant.homeTabShimmerCell.rawValue) as! HomeTabShimmerCell
            backButton.isHidden = true
            return cell
        }

        if indexPath.section == 0 {
            
            switch indexPath.row{
            case 0 :
                if true{
                    let cell = tableView.getCell(identifier: CellConstant.activeOrderHomeTabCell.rawValue) as! ActiveOrderHomeTabCell
                    return cell
                }else{
                    let cell = tableView.getCell(identifier: CellConstant.goldCategoryCardCellTableViewCell.rawValue) as! GoldCategoryCardCellTableViewCell
                    return cell
                }
            case 1:
                let cell = tableView.getCell(identifier: CellConstant.bannerHomeTabCell.rawValue) as! BannerHomeTabCell
                cell.bannerData = viewModel.loyaltyDetail
                cell.setupUi()
                return cell
            default:
                return UITableViewCell()
            }
        }else if indexPath.section == 1{
            
            switch indexPath.row{
            case 0 :
                let cell = tableView.getCell(identifier: CellConstant.advertisementCell.rawValue) as! AdvertisementCell
                cell.advertisementBannerData = viewModel.banner
                cell.reloadData()
                return cell
            case 1:
                let cell = tableView.getCell(identifier: CellConstant.foodCatrgoryCell.rawValue) as! FoodCatrgoryCell
                cell.foodCategoryData = viewModel.tags
                return cell
            case 2:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.hometabDelegate = self
                cell.resturentTableViewCellData = viewModel.recentlyAddedStores
                cell.setUpCellData(storeTitle: viewModel.recentlyAddedTitle ?? TextConstant.resturent.rawValue)
                cell.reloadCOllectionView()
                return cell
            case 3:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.hometabDelegate = self
                cell.resturentTableViewCellData = viewModel.nearbyResturentStore
                cell.setUpCellData(storeTitle: viewModel.nearbyResturentTitle ?? TextConstant.resturent.rawValue)
                cell.reloadCOllectionView()
                return cell
            case 4:
                let cell = tableView.getCell(identifier: CellConstant.resturentTableViewCell.rawValue) as! ResturentTableViewCell
                cell.hometabDelegate = self
                cell.resturentTableViewCellData = viewModel.mostPopularStore
                cell.setUpCellData(storeTitle: viewModel.mostPopularTitle ?? TextConstant.resturent.rawValue)
                cell.reloadCOllectionView()
                return cell
            default:
                
                if viewModel.homeScreenStoreListData?.count == ( indexPath.row - 4 ){
                    viewModel.callHomeScreenStorelistNextPageApi()
                }
                
                let cell = tableView.getCell(identifier: CellConstant.resturentDetailsTableViewCell.rawValue) as! ResturentDetailsTableViewCell
                cell.resturentDetailsTableViewCellData = viewModel.homeScreenStoreListData?[indexPath.row - 5]
                cell.reloadCellData()
                return cell
            }
        }else{
            let cell = tableView.getCell(identifier: "StoreShimmerCell") as! StoreShimmerCell
            cell.deligate = self
            cell.isStoreApiFailed = viewModel.isStoreApiFailed
            cell.setUpCellState()
            return cell
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
    
}
