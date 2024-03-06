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
    
    var selectedViewTriangleLayer = CAShapeLayer()
    var lowViewTriangleLayer = CAShapeLayer()
    
    var resturentDelegate : HomeTblCollViewAction?
    var currentCellIndexpath : IndexPath?
    var resturentDetailsData : Stores?
    var isHeigthChnaged = false
    var resturentFeatureDate : [featureDetails]?
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setDeligate()
        setupCollectionView()
        registerCell()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawTriangleforlowdeleveryView()
        drawTriangleforSelectedView()
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
    
    func setupTapgesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        resturentFeatureCollectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc func labelTapped() {
        resturentDelegate?.animateResturentCell(Indexpath: currentCellIndexpath ?? IndexPath())
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
        selectedViewTriangleLayer.removeFromSuperlayer()
        let trianglePath = UIBezierPath()
        
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft{
            let startX = parentCellView.frame.maxX+5
            let startY = selectedItemView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX-10 , y: startY+10))
            trianglePath.addLine(to: CGPoint(x: startX-10, y: startY))
            trianglePath.close()
        }else{
            let startX = parentCellView.frame.minX+2.5
            let startY = selectedItemView.frame.maxY
            
            // Move to starting point
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX , y: startY+12))
            trianglePath.addLine(to: CGPoint(x: startX-7, y: startY))
            trianglePath.close()
            
        }
        
        // Configure the layer
        selectedViewTriangleLayer.path = trianglePath.cgPath
        selectedViewTriangleLayer.fillColor = UIColor(red: 0.72, green: 0.39, blue: 0.14, alpha: 1).cgColor
        selectedViewTriangleLayer.zPosition = -1
        self.layer.addSublayer(selectedViewTriangleLayer)
    }
    
    func drawTriangleforlowdeleveryView() {
        lowViewTriangleLayer.removeFromSuperlayer()
        let trianglePath = UIBezierPath()
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft{
            let startX = parentCellView.frame.maxX+5
            let startY = lowdeleveryView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX-10 , y: startY+10))
            trianglePath.addLine(to: CGPoint(x: startX-10, y: startY))
            trianglePath.close()
        }else{
            let startX = parentCellView.frame.minX+2.5
            let startY = lowdeleveryView.frame.maxY
            
            trianglePath.move(to: CGPoint(x: startX , y: startY))
            trianglePath.addLine(to: CGPoint(x: startX , y: startY+15))
            trianglePath.addLine(to: CGPoint(x: startX-7, y: startY))
            trianglePath.close()
        }
        // Configure the layer
        lowViewTriangleLayer.path = trianglePath.cgPath
        lowViewTriangleLayer.fillColor = UIColor(red: 0.67, green: 0.66, blue: 0.66, alpha: 1).cgColor
        lowViewTriangleLayer.zPosition = -1
        self.layer.addSublayer(lowViewTriangleLayer)
    }
    
    func hidelowDeleveryView(){
        lowdeleveryView.isHidden = true
        lowDeleveryfeelbl.isHidden = true
    }
    func setupReloadedData(){
        SDWebImageManagerRevamp.shared.loadImage(with: resturentDetailsData?.image_url ?? "", into: resturentImage)
        resturentTitle.text = resturentDetailsData?.name ?? ""
        resturentTitle.setProperties(lbltext: resturentDetailsData?.name ?? "", fontSize: 20,alignmentLeft:true)
        if resturentDetailsData?.offer == "" {
            selectedItemOffLbl.setProperties(lbltext: "Get off on selected items", fontSize: 12,color:ColorConstant.whitecolor, alignmentLeft:true)
        }else{
            selectedItemOffLbl.setProperties(lbltext: resturentDetailsData?.offer ?? "Get off on selected items", fontSize: 12,color:ColorConstant.whitecolor, alignmentLeft:true)
        }
        
    }
    
    func setupUI(){
        // setup offer stricker
        setupOfferView()
        
        // hide the scroll indicator
        resturentFeatureCollectionView.showsHorizontalScrollIndicator = false
        
        // setup rsturent details view
        applyCornerRadius(to: resturentInternelView, radius: 15, corners: .Bottom, borderColor:ColorConstant.borderColorGray , borderWidth: 1)
        
        // setupTap gesture
        setupTapgesture()
        
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
