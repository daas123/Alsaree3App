//
//  ResturentDetailsCollectionViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//

import UIKit

class ResturentDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var parentCellView: UIView!
    @IBOutlet weak var resturentInternelView: UIView!
    @IBOutlet weak var selectedItemView: UIView!
    @IBOutlet weak var selectedItemOffLbl: UILabel!
    @IBOutlet weak var lowdeleveryView: UIView!
    @IBOutlet weak var lowDeleveryfeelbl: UILabel!
    @IBOutlet weak var resturentTitle: UILabel!
    @IBOutlet weak var resturentImage: UIImageView!
    @IBOutlet weak var resturentFeatureCollectionView: UICollectionView!
    
    var resturentDetailsData : Stores?
    var isHeigthChnaged = false
    var resturentFeatureDate : [featureDetails]?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setDeligate()
        setupCollectionView()
        registerCell()
        drawTriangleforSelectedView()
        drawTriangleforlowdeleveryView()
    }
    
    func reloadCollectionView(){
        setupReloadedData()
        setupFeatureDetails()
    }
    
    func setupFeatureDetails(){
        resturentFeatureDate = [
            featureDetails(featureValue: "500+", image: "Heart",istinted: false),
            featureDetails(featureValue: (String(format: "%.2f", resturentDetailsData?.distance ?? 0.0)+" KM Away"), image: nil, istinted: true),
            featureDetails(featureValue: "\(resturentDetailsData?.delivery_time ?? 0) - \(resturentDetailsData?.delivery_time_max ?? 0) Mins", image:"Location", istinted: true),
            featureDetails(featureValue: " IQD \(resturentDetailsData?.delivery_price_after_discount ?? 0) ", image: "MotorCycle", istinted: true),
            featureDetails(featureValue: "\(String(format: "%.2f", resturentDetailsData?.user_rate ?? 0.0)) Excellent", image: "Star",istinted: true)
            
        ]
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        self.resturentFeatureCollectionView.frame = self.bounds
        self.resturentFeatureCollectionView.layoutIfNeeded()
        
        if isHeigthChnaged{
            return self.resturentFeatureCollectionView.contentSize
        }else{
            resturentFeatureCollectionView.contentSize.height += 50
            isHeigthChnaged = true
            return self.resturentFeatureCollectionView.contentSize
        }
    }
    
    func setupCollectionView(){
        let layout = TagFlowLayout()
        layout.estimatedItemSize = CGSize(width: 140, height: 40)
        resturentFeatureCollectionView.collectionViewLayout = layout
    }
    
    func registerCell(){
        resturentFeatureCollectionView.registerNib(of: FeatureCell.self)
    }
    
    func setDeligate(){
        resturentFeatureCollectionView.delegate = self
        resturentFeatureCollectionView.dataSource = self
    }
    
    func drawTriangleforSelectedView() {
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        // Starting point for the path (the bottom left of the triangle)
        let startX = selectedItemView.frame.minX
        let startY = selectedItemView.frame.maxY
        
        // Move to starting point
        trianglePath.move(to: CGPoint(x: startX, y: startY-13))
        trianglePath.addLine(to: CGPoint(x: startX+10 , y: startY-13))
        trianglePath.addLine(to: CGPoint(x: startX+10, y: startY))
        trianglePath.close()
        
        // Configure the layer
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor(red: 0.72, green: 0.39, blue: 0.14, alpha: 1).cgColor
        triangleLayer.zPosition = -1
        self.layer.addSublayer(triangleLayer)
    }
    
    func drawTriangleforlowdeleveryView() {
        let triangleLayer = CAShapeLayer()
        let trianglePath = UIBezierPath()
        
        // Starting point for the path (the bottom left of the triangle)
        let startX = lowdeleveryView.frame.minX
        let startY = lowdeleveryView.frame.maxY
        
        // Move to starting point
        trianglePath.move(to: CGPoint(x: startX, y: startY-26))
        trianglePath.addLine(to: CGPoint(x: startX+10 , y: startY-26))
        trianglePath.addLine(to: CGPoint(x: startX+10, y: startY-10))
        trianglePath.close()
        
        // Configure the layer
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor(red: 0.67, green: 0.66, blue: 0.66, alpha: 1).cgColor
        triangleLayer.zPosition = -1
        self.layer.addSublayer(triangleLayer)
    }
    
    func hidelowDeleveryView(){
        lowdeleveryView.isHidden = true
        lowDeleveryfeelbl.isHidden = true
    }
    func setupReloadedData(){
        SDWebImageManager.shared.loadImage(with: resturentDetailsData?.image_url ?? "", into: resturentImage)
        setLabelText(lblrefrence: resturentTitle, lbltext: resturentDetailsData?.name ?? "", fontSize: 20,alignmentLeft:true)
        if resturentDetailsData?.offer == "" {
            setLabelText(lblrefrence: selectedItemOffLbl, lbltext: "Get off on selected items", fontSize: 12,alignmentLeft:true)
        }else{
            setLabelText(lblrefrence: selectedItemOffLbl, lbltext: resturentDetailsData?.offer ?? "Get off on selected items", fontSize: 12,alignmentLeft:true)
        }
        
    }

    func setupUI(){
        
        // setup low delevery sticker
        lowdeleveryView.backgroundColor = UIColor.white
        lowdeleveryView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        lowdeleveryView.layer.borderWidth = 0.5
        setLabelText(lblrefrence: lowDeleveryfeelbl, lbltext: "Low delivery fee", fontSize: 12,alignmentLeft:true)
        applyCornerRadius(to: lowdeleveryView, radius: 5)
        
        // setup offer stricker

        selectedItemView.backgroundColor = ColorConstant.primaryYellowColor
        applyCornerRadius(to: selectedItemView, radius: 5)
        
        // hide the scroll indicator
        resturentFeatureCollectionView.showsHorizontalScrollIndicator = false
        
        // setup rsturent details view
        resturentInternelView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        resturentInternelView.layer.borderWidth = 1
        resturentInternelView.layer.cornerRadius = 15
        resturentInternelView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        resturentInternelView.clipsToBounds = true
        
        // image Curve code
        resturentImage.layer.cornerRadius = 15
        resturentImage.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        resturentImage.layer.borderColor = ColorConstant.borderColorGray.cgColor
        resturentImage.layer.borderWidth = 0.2
        resturentImage.clipsToBounds = true
        
        // adding the shadow
        
    }
    
    func applyCornerRadius(to view: UIView, radius: CGFloat) {
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    
    
}


extension ResturentDetailsCollectionViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        resturentFeatureDate?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellConstant.featureCell.rawValue, for: indexPath) as! FeatureCell
        cell.feature = resturentFeatureDate?[indexPath.row]
        cell.fillDetails()
        cell.featurelbl.preferredMaxLayoutWidth = collectionView.frame.width - 16
        
        return cell
    }
}

extension ResturentDetailsCollectionViewCell:UICollectionViewDelegate{
    
}

extension ResturentDetailsCollectionViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: resturentFeatureCollectionView.bounds.width, height: resturentFeatureCollectionView.bounds.height)
    }
    
}
