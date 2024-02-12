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
    
    var errorView = UIView()
    var isStoreApiFailed : Bool = false
    
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
//        if isStoreApiFailed{
//            stopShimmer()
//            showCustomErrorMessage(nameNib: nibNamesConstant.cellErrorHandlingView.rawValue, uiView: parentView)
//        }else{
//            setUpShimmerViews()
//        }
//        errorView.removeFromSuperview()
        
    }
    
    func showCustomErrorMessage(nameNib:String, uiView:UIView) {
        errorView = loadErrorViewFromNib(nibName:nameNib) ?? UIView()
        uiView.addSubview(errorView)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: uiView.topAnchor),
            parentView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            parentView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
        ])
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
