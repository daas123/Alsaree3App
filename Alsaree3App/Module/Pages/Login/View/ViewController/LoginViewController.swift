//
//  LoginViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/02/24.
//

import UIKit
import IQKeyboardManager
class LoginViewController: BaseViewController {
    @IBOutlet var loginTableView : UITableView!
    @IBOutlet weak var proceedBtnParentView: UIView!
    @IBOutlet var proceedBtn : UIButton!
    @IBOutlet weak var topBarView: UIView!
    
    var alertView : StaticAlert!
    var viewModel = LoginViewModel()
    var isUserWantsReferal = false
    var isKeybordVisible = false
    var customPresentationController: PresentationController?
    var isProceedBtnActive = true
    var presentingcontroller : ProfileTabViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.shared().isEnabled = false
        self.customPresentationController?.containerViewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.getCountryList()
    }
    
    override func viewWillLayoutSubviews() {
//        let alertY: CGFloat = self.proceedBtnParentView.frame.origin.y - UIScreen.main.bounds.height*0.04 - 5
//        let nib = UINib(nibName: "StaticAlert", bundle: nil)
//        alertView = nib.instantiate(withOwner: nil, options: nil).first as? StaticAlert
//        alertView.setupMessageLbl(errorText: "Agree terms and Condition")
//        alertView.frame = CGRect(x: 0, y: alertY, width: view.bounds.width, height: UIScreen.main.bounds.height*0.04)
//        view.addSubview(alertView)
//        alertView.isHidden = true
        
        proceedBtnParentView.addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
    }
    
    func setupUI(){
        setupDeligate()
        regTableviewCell()
        setupTableview()
        setupProceedBtn()
        setupNotificationObserver()
        setupTopbar()
    }
    
    func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupDeligate(){
        loginTableView.delegate = self
        loginTableView.dataSource = self
    }
    
    func setupTopbar(){
        topBarView.layer.cornerRadius = topBarView.bounds.height / 2
    }
    
    func regTableviewCell(){
        loginTableView.registerNib(of: UserNameTblVwCell.self)
        loginTableView.registerNib(of: MobileNoTblVwCell.self)
        loginTableView.registerNib(of: ReferralLblTblVwCell.self)
        loginTableView.registerNib(of: ReferralCodeTblVwCell.self)
        loginTableView.registerNib(of: TermsConditionTblVwCell.self)
    }
    
    func setupTableview(){
        loginTableView.separatorStyle = .none
        loginTableView.showsVerticalScrollIndicator = false
    }
    
    func setupProceedBtn(isActive : Bool = false){
        if isActive && !viewModel.isAnyError(){
            proceedBtn.setProperties(label: "Proceed",color: ColorConstant.whitecolor ,size: 18,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10,tintcolor: ColorConstant.borderColorGray)
            isProceedBtnActive = true
        }else{
            proceedBtn.setProperties(label: "Proceed",color: ColorConstant.whitecolor ,size: 18,backcolor: ColorConstant.primaryGrayBrownColor,cornerRadius: 10,tintcolor: ColorConstant.borderColorGray)
            isProceedBtnActive = false
        }
    }
    
    @IBAction func onClickProceedBtn(_ sender: UIButton) {
        if isProceedBtnActive && !viewModel.isAnyError(){
            self.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "RestaurantDetailsVC") as! RestaurantDetailsVC
                let presetingVc = self.customPresent(viewController: vc, presentingHeigth: self.viewModel.getpresentingHeight(screenHeigth: UIScreen.main.bounds.height))
                self.presentingcontroller?.navigationController?.present(vc, animated: true)
            }
        }else{
           if viewModel.userNameErorr != nil{
               
           }else if viewModel.mobileNoErorr != nil{
               print("Mobile No error")
           }else if !isProceedBtnActive{
               print("select terms and condition")
           }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeybordVisible{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if let presentedViewheigth = customPresentationController?.customHeight{
                    if presentedViewheigth+(keyboardSize.height/1000) >= 0.9{
                        customPresentationController?.customHeight = 0.85
                        loginTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height - 10), right: 0)
                    }else{
                        customPresentationController?.customHeight += keyboardSize.height/1000
                        loginTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardSize.height - 10), right: 0)
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
            var presentingheigth = viewModel.getpresentingHeight(screenHeigth: UIScreen.main.bounds.height)
            if isUserWantsReferal {
                customPresentationController?.customHeight = presentingheigth + 0.06
            }else{
                customPresentationController?.customHeight = presentingheigth
            }
            UIView.animate(withDuration: 0.3, animations: {
                self.customPresentationController?.containerViewDidLayoutSubviews()
            })
            loginTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            isKeybordVisible = false
        }
    }
    
    func showCustomAlert(errorText:String){
        alertView.setupMessageLbl(errorText: errorText)
        alertView.alpha = 0 // invisible
        alertView.isHidden = true
        
        // animate the alert view to fade in
        if alertView.isHidden{
            alertView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.alertView.alpha = 1
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0 ) {
            // animate the alert view to fade out
            UIView.animate(withDuration: 0.5, animations: {
                self.alertView.alpha = 0
            }, completion: { _ in
                self.alertView.isHidden = true
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}


extension LoginViewController : LoginCellAlignment{
    func addReferalCodecell() {
        customPresentationController?.customHeight += 0.06
        UIView.animate(withDuration: 0.3, animations: {
            self.customPresentationController?.containerViewDidLayoutSubviews()
        })
        self.isUserWantsReferal = true
        DispatchQueue.main.async {
            self.loginTableView.reloadData()
        }
    }
}

extension LoginViewController : updateProceedbtnState{
    func updateProceedBtn(isActive: Bool) {
        if isActive{
            isProceedBtnActive = true
        }
        setupProceedBtn(isActive: isActive)
    }
    
}
