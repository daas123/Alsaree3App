//
//  HomeTabShimmerCell.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 19/01/24.
//

import UIKit

class HomeTabShimmerCell: UITableViewCell {
    
    @IBOutlet var shimmmerViews : [UIView]!
    @IBOutlet var circleShimmerViews : [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpShimmerViews()
        setUpCircleShimmerViews()
    }
    
    func setUpShimmerViews(){
        for shimmerView in shimmmerViews{
            shimmerView.backgroundColor = UIColor.clear
            shimmerView.layer.cornerRadius = 8
            ShimmeringView().startShining(shimmerView)
        }
    }
    
    func setUpCircleShimmerViews(){
        for circleShimmerView in circleShimmerViews{
            circleShimmerView.backgroundColor = UIColor.clear
            circleShimmerView.layer.cornerRadius = circleShimmerView.bounds.width/2
            ShimmeringView().startShining(circleShimmerView)
        }
    }
    
}
