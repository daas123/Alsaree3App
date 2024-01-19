//
//  BannerHomeTabCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class BannerHomeTabCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    var bannerData : LoyaltyDetailsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    
    func setupUi(){
        bannerImageView.layer.borderWidth = 0.5
        bannerImageView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.layer.cornerRadius = 11
        
        if bannerData == nil {
            showErrorMessage(nameNib: "CellErrorHandlingView", uiView:bannerImageView)
            SDWebImageManager.shared.loadImage(with:bannerData?.zero_point_image_url ?? "", into: bannerImageView, isbaseUrlRequired: false)
        } else {
            loadBannerImage()
        }
        
    }
    
    private func loadBannerImage() {
        SDWebImageManager.shared.loadImage(with: bannerData?.zero_point_image_url ?? "", into: bannerImageView, isbaseUrlRequired: false)
    }
    

    
}
