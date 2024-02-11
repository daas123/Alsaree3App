//
//  LoadingTableViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 20/12/23.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingTitle: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    var homeTabdeilgate : HomeTabViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        loadingTitle.setProperties(lbltext: "Try searching with food emojis today", fontSize: 20,lineHeightMultiple: 0.7)
        let imageSize = CGSize(width: 25, height: 25)
        retryButton.setPropertiesWithImage(label: "  Retry Loading", image: "retry", fontSize: 20, imageSize: imageSize)
    }
    
    
    @IBAction func onRetryClick(_ sender: UIButton) {
        homeTabdeilgate?.viewModel.isApiCallFailed = false
        homeTabdeilgate?.viewModel.isLoadingState = true
        homeTabdeilgate?.viewModel.callFullHomeScreenApi()
    }
    
    func showLoading(){
        retryButton.isHidden = true
        loadingView.isHidden = false
        loadingTitle.isHidden = false
    }
    
    func showRetryButton(){
        loadingView.isHidden = true
        loadingTitle.isHidden = true
    }
    
}
