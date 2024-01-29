//
//  HomeTabViewScrollViewDeligate.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import UIKit

extension HomeTabViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //MARK:  for sticky header
        if viewModel.recentlyAddedStores == nil || viewModel.homeScreenStoreListData == nil {
            return
        }
        setupSteckyHeader(scrollView)
        setupScrollToTop(scrollView)
        
        //MARK: For tab bar hide/show
        let currentScrollOffset = scrollView.contentOffset.y
        let scrollDirection: ScrollDirection
        if currentScrollOffset > previousScrollOffset {
            scrollDirection = .down
        } else if currentScrollOffset < previousScrollOffset {
            scrollDirection = .up
        } else {
            scrollDirection = .none
        }
        
        let threshold: CGFloat = 100
        if currentScrollOffset > threshold {
            updateTabBarVisibility(for: scrollDirection)
        }
        
        previousScrollOffset = currentScrollOffset
        
        
    }
    
    private func updateTabBarVisibility(for scrollDirection: ScrollDirection) {
        let isScrollingDown = scrollDirection == .down
        let isScrollingUp = scrollDirection == .up
        
        let animationDuration: TimeInterval = 0.3
        
        UIView.animate(withDuration: animationDuration, animations: {
            // Adjust the Y-coordinate based on the scroll direction
            self.tabBarController?.tabBar.frame.origin.y = isScrollingDown ?
            (self.view.frame.origin.y + self.view.frame.size.height) :
            (self.view.frame.origin.y + self.view.frame.size.height - self.tabBarController!.tabBar.frame.size.height)
        }) { (_) in
            // Optionally, you can add completion code here if needed
        }
        
    }
    
    func setupSteckyHeader(_ scrollView: UIScrollView){
        if viewModel.recentlyAddedStores == nil || viewModel.homeScreenStoreListData == nil {
            return
        }
        let headerRect = hometabTableView.rect(forSection: 1)
        if headerRect.origin.y <= scrollView.contentOffset.y && scrollView.contentOffset.y <= headerRect.origin.y + headerRect.size.height {
            headerView?.hideImages()
            headerView?.setCustomConstrain(heigtht: 40)
            //            showProgressView()
            headerView?.categroyBackView.backgroundColor = ColorConstant.borderColorGray
        } else {
            headerView?.backgroundColor = UIColor.clear
            headerView?.showImages()// Reset to original height here
            headerView?.setDefaultConstrain()
            hideProgressView()
            headerView?.categroyBackView.backgroundColor = UIColor.clear
        }
    }
    
    func setupScrollToTop(_ scrollView: UIScrollView ){
        if viewModel.recentlyAddedStores == nil || viewModel.homeScreenStoreListData == nil {
            return
        }
        
        let yOffset = scrollView.contentOffset.y
        let threshold: CGFloat = hometabTableView.bounds.height
        
        if yOffset >= threshold {
            // The user has scrolled beyond the threshold, make the button visible
            UIView.animate(withDuration: 0.5) {
                self.backButton.isHidden = false
            }
        } else {
            // The user is above the threshold, hide the button
            UIView.animate(withDuration: 0.5) {
                self.backButton.isHidden = true
            }
        }
        
    }
    
}
