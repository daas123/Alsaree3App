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
    
    func setUpShimmerViews(){
        ShimmeringView().startShining(shimmerImageView)
        for shimmerView in shimmerView{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().startShining(shimmerView)
        }
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
