//
//  BannerHomeTabCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class BannerHomeTabCell: UITableViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    var bannerData : LoyaltyDetailsModel?
    var homeTabDelegate : NavigateFormHomeTab?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
    }
    
    
    func setupUi(){
        bannerImageView.layer.borderWidth = 0.5
        bannerImageView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.layer.cornerRadius = 11
        errorLbl.setProperties(lbltext: "Something Went Wrong", fontSize: 16,color: ColorConstant.primaryYellowColor)
        errorBtn.setPropertiesWithImage(label: "  Retry",image: ImageConstant.retry.rawValue, textColor: ColorConstant.whitecolor ,fontSize: 16, imageSize: CGSize(width: 20, height: 20),backColor: ColorConstant.primaryYellowColor,cornerRadius:10)
        errorBtn.addBounceBackAnimation()
        
        if bannerData == nil {
            SDWebImageManagerRevamp.shared.loadImage(with:bannerData?.zero_point_image_url ?? "", into: bannerImageView, isbaseUrlRequired: false)
            errorView.isHidden = false
        } else {
            errorView.isHidden = true
            loadBannerImage()
        }
        
    }
    
    private func loadBannerImage() {
        SDWebImageManagerRevamp.shared.loadImage(with: bannerData?.zero_point_image_url ?? "", into: bannerImageView, isbaseUrlRequired: false)
    }
    
    @IBAction func onRetry(_ sender: UIButton) {
        homeTabDelegate?.reloadBanner()
    }
    
}
