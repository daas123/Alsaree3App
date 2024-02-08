//
//  ResturentDetailsTableViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 20/12/23.
//

import UIKit

class ResturentDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resturentDetailsView: UIView!
    @IBOutlet weak var selectedItemView: UIView!
    @IBOutlet weak var selectedItemOffLbl: UILabel!
    @IBOutlet weak var lowdeleveryView: UIView!
    @IBOutlet weak var lowDeleveryfeelbl: UILabel!
    @IBOutlet weak var resturentTitle: UILabel!
    @IBOutlet weak var resturentImage: UIImageView!
    @IBOutlet weak var resturentFutrCollectionView: UICollectionView!
    
    var isStoreClose : Bool = false
    var resturentDetailsTableViewCellData : Stores?
    var resturentFeatureDate : [featureDetails]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupCollectionViewLayout()
        resturentFutrCollectionView.registerNib(of: FeatureCell.self)
        setDeligate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawTriangleforSelectedView()
        drawTriangleforlowdeleveryView()
    }
    
    func setupCollectionViewLayout(){
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 70, height: 0)
        resturentFutrCollectionView.collectionViewLayout = layout
        
    }
    
    func reloadCellData(){
        SDWebImageManagerRevamp.shared.loadImage(with: resturentDetailsTableViewCellData?.image_url ?? "", into: resturentImage)
        resturentTitle.setProperties(lbltext: resturentDetailsTableViewCellData?.name ?? "", fontSize: 20,alignmentLeft:true)
        if resturentDetailsTableViewCellData?.offer == "" {
            selectedItemOffLbl.setProperties( lbltext: TextConstant.getoffonselecteditems.rawValue, fontSize: 12,alignmentLeft:true)
        }else{
            selectedItemOffLbl.setProperties(lbltext: resturentDetailsTableViewCellData?.offer ?? TextConstant.getoffonselecteditems.rawValue, fontSize: 12,alignmentLeft:true)
        }
        
        setupFeatureDetails()
        if isStoreClose{
            setupCloseStore()
        }
    }
    
    func setDeligate(){
        resturentFutrCollectionView.delegate = self
        resturentFutrCollectionView.dataSource = self
    }
    
    func setupUI(){
        // setup offer stricker
        setupOfferView()
        
        // hide the scroll indicator
        resturentFutrCollectionView.showsHorizontalScrollIndicator = false
        
        // setup rsturent details view
        applyCornerRadius(to: resturentDetailsView, radius: 15, corners: .All, borderColor:ColorConstant.borderColorGray , borderWidth: 1)
        
        // image Curve code
        applyCornerRadius(to: resturentImage, radius: 15, corners: .Top, borderColor: ColorConstant.borderColorGray, borderWidth: 0.2)
    }
    
    func setupOfferView(){
        
        //OfferView : LowDeliveryView
        lowdeleveryView.backgroundColor = UIColor.white
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            applyCornerRadius(to: lowdeleveryView, radius: 5, corners: .Left,borderColor: ColorConstant.borderColorGray, borderWidth: 0.5)
        }else{
            applyCornerRadius(to: lowdeleveryView, radius: 5, corners: .Right,borderColor: ColorConstant.borderColorGray, borderWidth: 0.5)
        }
        lowDeleveryfeelbl.setProperties(lbltext: "Low delivery fee", fontSize: 12,alignmentLeft:true)
        
        //OfferView : selectedItemView
        selectedItemView.backgroundColor = ColorConstant.primaryYellowColor
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            applyCornerRadius(to: selectedItemView, radius: 5, corners: .Left,borderWidth: 0.5)
        }else{
            applyCornerRadius(to: selectedItemView, radius: 5, corners: .Right, borderWidth: 0.5)
        }
        
    }
    
    func setupFeatureDetails(){
        resturentFeatureDate = [
            featureDetails(featureValue: "500+", image: "Heart",istinted: false),
            featureDetails(featureValue: (String(format: "%.2f", resturentDetailsTableViewCellData?.distance ?? 0.0)+" KM Away"), image: nil, istinted: true),
            featureDetails(featureValue: "\(resturentDetailsTableViewCellData?.delivery_time ?? 0) - \(resturentDetailsTableViewCellData?.delivery_time_max ?? 0) Mins", image:"Location", istinted: true),
            featureDetails(featureValue: " IQD \(resturentDetailsTableViewCellData?.delivery_price_after_discount ?? 0) ", image: "MotorCycle", istinted: true),
            featureDetails(featureValue: "\(String(format: "%.2f", resturentDetailsTableViewCellData?.user_rate ?? 0.0)) Excellent", image: "Star",istinted: true)
            
        ]
    }
    
    
    func applyCornerRadius(to view: UIView, radius: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    
    func drawTriangleforSelectedView() {
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft{
            let startX = resturentDetailsView.frame.maxX+5
            let startY = selectedItemView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX-10 , y: startY+10))
            trianglePath.addLine(to: CGPoint(x: startX-10, y: startY))
            trianglePath.close()
        }else{
            // Starting point for the path (the bottom left of the triangle)
            let startX = selectedItemView.frame.minX
            let startY = selectedItemView.frame.maxY
            
            // Move to starting point
            trianglePath.move(to: CGPoint(x: startX+10, y: startY)) //rigth side point
            trianglePath.addLine(to: CGPoint(x: startX , y: startY)) // left side point
            trianglePath.addLine(to: CGPoint(x: startX+10, y: startY+15)) // bottem point
            trianglePath.close()
            
        }
        
        // Configure the layer
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor(red: 0.72, green: 0.39, blue: 0.14, alpha: 1).cgColor
        triangleLayer.zPosition = -1
        self.layer.addSublayer(triangleLayer)
    }
    
    func drawTriangleforlowdeleveryView() {
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft{
            let startX = resturentDetailsView.frame.maxX+5
            let startY = lowdeleveryView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX-10 , y: startY+10))
            trianglePath.addLine(to: CGPoint(x: startX-10, y: startY))
            trianglePath.close()
        }else{
            let startX = lowdeleveryView.frame.minX
            let startY = lowdeleveryView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX+10, y: startY))
            trianglePath.addLine(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX+10, y: startY+15))
            trianglePath.close()
        }
        // Configure the layer
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor(red: 0.67, green: 0.66, blue: 0.66, alpha: 1).cgColor
        triangleLayer.zPosition = -1
        self.layer.addSublayer(triangleLayer)
    }
    
    func setupCloseStore(){
        showErrorMessage(nameNib: nibNamesConstant.closeStoreView.rawValue, uiView: self)
    }
    
    
}

extension ResturentDetailsTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resturentFeatureDate?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstant.featureCell.rawValue, for: indexPath) as! FeatureCell
        cell.feature = resturentFeatureDate?[indexPath.row]
        //        cell.featurelbl.preferredMaxLayoutWidth = collectionView.frame.width/1.5
        cell.fillDetails()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: resturentFutrCollectionView.layer.bounds.width, height: resturentFutrCollectionView.layer.bounds.height)
    }
    
    
}
