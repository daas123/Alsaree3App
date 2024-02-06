//
//  ActiveOrderHomeTabCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit


class ActiveOrderHomeTabCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var activeOrderlbl: UILabel!
    @IBOutlet weak var orderDescriptionlbl: UILabel!
    @IBOutlet weak var orderProgressimg: UIImageView!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var subViewWithBorder: UIView!
    @IBOutlet weak var progressView: UIView!
    
    
    // MARK: Local Variable
    var circularProgressView: CircularProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setUpCircularprogress(currentProgress: 0.3)
    }
    
    func setUpCircularprogress(currentProgress: Float){
        progressView.layer.cornerRadius = (progressView.bounds.width + 4)/2
        progressView.backgroundColor = UIColor.clear
        
        // Adding the Frame
        circularProgressView = CircularProgressView(frame: progressView.bounds, lineWidth: 2, rounded: true)
        circularProgressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Adding color to Progress view
        circularProgressView.progressColor = ColorConstant.primaryYellowColor
        circularProgressView.trackColor = ColorConstant.borderColorGray
        
        progressView.addSubview(circularProgressView)
        
        // for demo Added some Value
        circularProgressView.setProgress(to: currentProgress)
    }
    func setupUI(){
        
        // setting the label text and images
        setLabelText(lblrefrence: activeOrderlbl, lbltext: TextConstant.activeOrder.rawValue, fontSize: 12 ,alignmentLeft: true)
        setLabelText(lblrefrence: orderDescriptionlbl, lbltext: TextConstant.orderNumber5thAvenueAlFurjanArea.rawValue, fontSize: 10 ,alignmentLeft: true)
        
        orderProgressimg.image = UIImage(named: ImageConstant.orderUpdate.rawValue)
        setImageOnButton(button: detailsBtn, image: ImageConstant.arrowRight.rawValue,isSystemImage: false)
        
        subViewWithBorder.layer.cornerRadius = 10
        subViewWithBorder.layer.borderColor = ColorConstant.primaryYellowColor.cgColor
        subViewWithBorder.layer.borderWidth = 2
        
        // setup background color
        self.backgroundColor = UIColor.clear
        subViewWithBorder.backgroundColor = ColorConstant.whitecolor
        self.selectionStyle = .none
    }
    
    @IBAction func onDetailsBtnClick(_ sender: UIButton) {
    }
    
}
