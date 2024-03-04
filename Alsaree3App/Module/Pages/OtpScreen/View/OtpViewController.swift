//
//  OtpViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 04/03/24.
//

import UIKit
import IQKeyboardManager

class OtpViewController: UIViewController {
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var verificatonLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var timeOutSecLbl: UILabel!
    @IBOutlet weak var resendCodeBtn: UIButton!
    @IBOutlet weak var OtpScrollView: UIScrollView!
    @IBOutlet var OptView: [UIView]!
    @IBOutlet var OtpLblTextfeild: [UITextField]!
    @IBOutlet weak var topBarView: UIView!
    
    
    var viewModel = OtpViewModel()
    var customPresentationController: PresentationController?
    var isKeybordVisible = false
    
    override func viewDidAppear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = false
        self.customPresentationController?.containerViewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotificationObserver()
        setupUi()
    }
    
    func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeybordVisible{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if let presentedViewheigth = customPresentationController?.customHeight{
                    if presentedViewheigth+(keyboardSize.height/1000) >= 0.9{
                        customPresentationController?.customHeight = 0.85
                        OtpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height), right: 0)
                    }else{
                        customPresentationController?.customHeight += keyboardSize.height/1000
                        OtpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height), right: 0)
                    }
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.customPresentationController?.containerViewDidLayoutSubviews()
                })
                isKeybordVisible = true
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            let presentingheigth = viewModel.getpresentingHeight(screenHeigth: UIScreen.main.bounds.height)
                customPresentationController?.customHeight = presentingheigth
            UIView.animate(withDuration: 0.3, animations: {
                self.customPresentationController?.containerViewDidLayoutSubviews()
            })
            OtpScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeybordVisible = false
        }
    }
    
    func setupUi(){
        setupTopbar()
        setupOtpView()
        verificatonLbl.setProperties(lbltext: "Verification Code", fontSize: 32)
        descriptionLbl.setProperties(lbltext: "Please Enter the Verification code we \n sent to you via WhatsApp", fontSize: 16,color: ColorConstant.primaryGrayBrownColor ,lineHeightMultiple: 0.75)
        timeOutSecLbl.setProperties(lbltext: "", fontSize: 14)
        resendCodeBtn.setProperties(label: "Resend the Code",color: ColorConstant.primaryYellowColor, size: 16,borderColor: ColorConstant.primaryYellowColor,cornerRadius: 10,borderWidth: 1)
    }
    
    func setupTopbar(){
        topBarView.layer.cornerRadius = topBarView.bounds.height / 2
    }
    
    func setupOtpView(){
        for otpView in OptView{
            otpView.layer.cornerRadius = otpView.bounds.height/2
            otpView.layer.borderWidth = 1
            otpView.layer.borderColor = ColorConstant.borderColorGray.cgColor
        }
        
        for otpLbl in OtpLblTextfeild{
            otpLbl.borderStyle = .none
            otpLbl.textAlignment = .center
        }
    }

}
