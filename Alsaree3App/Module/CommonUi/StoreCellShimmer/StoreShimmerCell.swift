//
//  StoreShimmerCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 08/02/24.
//

import UIKit

class StoreShimmerCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet var shimmerView: [UIView]!
    @IBOutlet weak var shimmerImageView: UIImageView!
    @IBOutlet weak var ErrorView: UIView!
    @IBOutlet weak var errorlbl: UILabel!
    @IBOutlet weak var tryAgainbtn: UIButton!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var parentShimmerview: UIView!
    
    var isStoreApiFailed : Bool = false
    var deligate : HomeTabViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        SetupUi()
        setUpCellState()
    }
    
    
    func SetupUi(){
        setUpCellState()
        shimmerImageView.layer.borderWidth = 0.5
        shimmerImageView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        tryAgainbtn.setPropertiesWithImage(label: "  Try Again ", image: ImageConstant.retry.rawValue, textColor: ColorConstant.whitecolor, fontSize: 14, imageSize: CGSize(width: 20, height: 20), backColor: ColorConstant.primaryYellowColor, cornerRadius: 5)
        tryAgainbtn.addBounceBackAnimation()
        applyCornerRadius(to: parentView, radius: 20,corners: .All,borderColor: ColorConstant.borderColorGray,borderWidth: 0.5)
        
    }
    
    func setUpCellState(){
        LoaderManager.shared.hideLoader()
        if !Connectivity.checkInternetAccess(isPresentScreen: false){
            ErrorView.isHidden = false
            parentShimmerview.isHidden = true
            errorlbl.setProperties(lbltext: "No Internet Access", fontSize: 18,isBold: true)
            errorImageView.setProperties(imageName: ImageConstant.noInternet.rawValue,isAspectFit: true)
        }else if !Connectivity.checkLocationAccess(isPresentScreen: false){
            errorlbl.isHidden = false
            parentShimmerview.isHidden = true
            errorlbl.setProperties(lbltext: "No Location Access", fontSize: 18,isBold: true)
            errorImageView.setProperties(imageName: ImageConstant.nolocation.rawValue,isAspectFit: true)
        }else if isStoreApiFailed{
            parentShimmerview.isHidden = false
            ErrorView.isHidden = false
            setUpShimmerViews()
            errorImageView.setProperties(imageName: "apierror",isAspectFit: true)
            errorlbl.setProperties(lbltext: "Something Went Wrong", fontSize: 18,isBold: true)
        }else{
            ErrorView.isHidden = true
            parentShimmerview.isHidden = false
            setUpShimmerViews()
        }
    }
    
    func setUpTagShimmer(){
        for shimmerView in shimmerView{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().startShining(shimmerView)
        }
    }
    
    func setUpShimmerViews(){
        ShimmeringView().startShining(shimmerImageView)
        setUpTagShimmer()
    }
    
    func stopShimmer(){
        ShimmeringView().stopShining(shimmerImageView)
        for shimmerView in shimmerView{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().stopShining(shimmerView)
        }
        
    }
    
    @IBAction func onClickTryAgain(_ sender: UIButton) {
        if Connectivity.checkNetAndLoc(isPresentScreen: false){
            LoaderManager.shared.showLoading(on: self.contentView)
            deligate?.viewModel.callHomeScreenStorelistNextPageApi()
        }else{
            if !Connectivity.checkInternetAccess(isPresentScreen: false){
                deligate?.showCustomAlert(errorText: "No Internet Access, kindly switch On Or check Network Avablity Zone")
            }else{
                deligate?.showCustomAlert(errorText: "No Location Access, kindly Allow the Access For Better Results")
            }
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
