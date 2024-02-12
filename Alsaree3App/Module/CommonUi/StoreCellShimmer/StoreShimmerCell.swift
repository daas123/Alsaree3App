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
    @IBOutlet weak var shimmerImageView: UIView!
    @IBOutlet weak var ErrorView: UIView!
    
    var isStoreApiFailed : Bool = false
    var deligate : HomeTabViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadius(to: parentView, radius: 20,corners: .All,borderColor: ColorConstant.borderColorGray,borderWidth: 0.5)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpShimmerViews()
//        SetupUi()
        self.selectionStyle = .none
    }
    
    func SetupUi(){
        if isStoreApiFailed{
            setUpShimmerViews()
            ErrorView.isHidden = false
        }else{
            ErrorView.isHidden = true
            stopShimmer()
        }
        
    }
    func setUpShimmerViews(){
        ShimmeringView().startShining(shimmerImageView)
        for shimmerView in shimmerView{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().startShining(shimmerView)
        }
        
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
        deligate?.viewModel.callHomeScreenStorelistNextPageApi()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
