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
    
    var isStoreApiFailed : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyCornerRadius(to: parentView, radius: 20,corners: .All,borderColor: ColorConstant.borderColorGray,borderWidth: 0.5)
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpShimmerViews()
        self.selectionStyle = .none
    }
    
    func SetupUi(){
        if isStoreApiFailed{
            stopShimmer()
            showErrorMessage(nameNib: nibNamesConstant.cellErrorHandlingView.rawValue, uiView:parentView)
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
        ShimmeringView().startShining(shimmerImageView)
        for shimmerView in shimmerView{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().startShining(shimmerView)
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
