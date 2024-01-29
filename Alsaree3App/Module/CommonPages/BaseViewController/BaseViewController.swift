//
//  BaseViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/01/24.
//

import UIKit

class BaseViewController: UIViewController {
    
//    var circularProgressView: CircularProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        NotificationManager().addObserver(forName: .networkStatusChanged) { _  in
            self.networkStatusDidChange()
        }
        NotificationManager().addObserver(forName: .networkStatusChanged) { _  in
            self.locationStatusChanged()
        }
        NotificationManager().addObserver(forName: .noLocationDeliverable) { _ in
            
        }
    }
    
    func networkStatusDidChange() {
        let storyboard = UIStoryboard(name: StoryBoardConstant.commonScreens.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerConstant.internetAccessViewController.rawValue) as! InternetAccessViewController
            self.present(viewController, animated: true, completion: nil)
    }
    
    func locationStatusChanged(){
            let storyboard = UIStoryboard(name: StoryBoardConstant.commonScreens.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:ViewControllerConstant.locationAccessViewController.rawValue) as! LocationAccessViewController
            self.present(viewController, animated: true, completion: nil)
    }
    
    
    func noLocationDeliverable(){
            let storyboard = UIStoryboard(name: StoryBoardConstant.commonScreens.rawValue, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier:ViewControllerConstant.noLocationDeliverableVc.rawValue) as! NoLocationDeliverableVc
            self.present(viewController, animated: true, completion: nil)
    }
    
    func setupHeaderView(headerNavigationView:UIView , applicationNamelbl:UILabel ,locationLbl:UILabel,downArrowImage:UIImageView,scooterimg:UIImageView){
        headerNavigationView.backgroundColor = ColorConstant.whitecolor
        headerNavigationView.addBottomBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
        
        // Setting the label and button values Manually
        view.setLabelText(lblrefrence: applicationNamelbl, lbltext: TextConstant.alsaree3App.rawValue, fontSize: 16,alignmentLeft: true)
        view.setLabelText(lblrefrence: locationLbl, lbltext: TextConstant.alFurjanArea.rawValue, fontSize: 12,lineHeightMultiple: 0.8)
        view.setImage(imageView: downArrowImage, imageName: ImageConstant.downArrow.rawValue)
        view.setImage(imageView: scooterimg, imageName: ImageConstant.scooter.rawValue)
        view.setCircleWithBorderColor(imageView: scooterimg, borderColor: ColorConstant.borderColorYellow, borderWidth: 1)
    }
    
    
//    func setUpCircularprogress(circularProgresView:UIView , currentProgress: Float ,progressLbl : UILabel){
//        circularProgresView.layer.cornerRadius = (circularProgresView.bounds.width + 4)/2
//        circularProgresView.backgroundColor = UIColor.clear
//        
//        // Adding the Frame
//        circularProgressView = CircularProgressView(frame: circularProgresView.bounds, lineWidth: 2, rounded: true)
//        circularProgressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        //Adding color to Progress view
//        circularProgressView.progressColor = ColorConstant.primaryYellowColor
//        circularProgressView.trackColor = ColorConstant.borderColorGray
//        
//        circularProgresView.addSubview(circularProgressView)
//        
//        // for demo Added some Value
//        circularProgressView.setProgress(to: currentProgress)
//        let percentage = Int(currentProgress * 100)
//        view.setLabelText(lblrefrence: progressLbl, lbltext: "\(percentage)%", fontSize: 12)
//        
//    }
   
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .networkStatusChanged, object: nil)
        NotificationCenter.default.removeObserver(self, name: .locationAccessRestricted, object: nil)
        NotificationCenter.default.removeObserver(self, name: .noLocationDeliverable, object: nil)
    }
    
}
