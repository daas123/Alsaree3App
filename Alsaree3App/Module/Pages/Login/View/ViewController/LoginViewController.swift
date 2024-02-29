//
//  LoginViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/02/24.
//

import UIKit
import IQKeyboardManager
class LoginViewController: UIViewController {
    
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
    
    func setupProceedBtn(isActive : Bool = true){
        if isActive{
            proceedBtn.setProperties(label: "Proceed",color: ColorConstant.whitecolor ,size: 18,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10,tintcolor: ColorConstant.borderColorGray)
            isProceedBtnActive = true
        }else{
            proceedBtn.setProperties(label: "Proceed",color: ColorConstant.whitecolor ,size: 18,backcolor: ColorConstant.primaryGrayBrownColor,cornerRadius: 10,tintcolor: ColorConstant.borderColorGray)
            isProceedBtnActive = false
        }
    }
    
    @IBAction func onClickProceedBtn(_ sender: UIButton) {
        if isProceedBtnActive{
            print("proceed")
        }else{
//            showCustomAlert(errorText: "Agree terms and Condition")
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
            var presentingheigth = 0.5
            if UIScreen.main.bounds.height > 900 {
                presentingheigth = 0.55
            } else if UIScreen.main.bounds.height > 700 {
                presentingheigth = 0.61
            } else {
                presentingheigth = 0.73
            }
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
extension LoginViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.getCell(identifier: "UserNameTblVwCell") as! UserNameTblVwCell
            cell.usernameLbl.delegate = self
            cell.setHeadingLbl(lblText: "User Name")
            cell.setUpErrorText(errText: viewModel.setupUsernameError())
            return cell
        case 1:
            let cell = tableView.getCell(identifier: "MobileNoTblVwCell") as! MobileNoTblVwCell
            cell.mobileNoLbl.delegate = self
            cell.setHeadingLbl(lblText: "Mobile Number")
            cell.setUpErrorText(errText: viewModel.setupMobileNoError())
            return cell
        case 2:
            if isUserWantsReferal{
                let cell = tableView.getCell(identifier: "ReferralCodeTblVwCell") as! ReferralCodeTblVwCell
                cell.referralCodeLbl.delegate = self
                cell.setHeadingLbl(lblText: "Referral Code")
                return cell
            }else{
                let cell = tableView.getCell(identifier: "ReferralLblTblVwCell") as! ReferralLblTblVwCell
                cell.setHeadingLbl(lblText: "Did your friend refer you? Press here to enter referral code")
                cell.profileTabdeligate = self
                return cell
            }
        case 3:
            let cell = tableView.getCell(identifier: "TermsConditionTblVwCell") as! TermsConditionTblVwCell
            cell.setTermsConditionLbl(text: "By continuing with login, you agree to have read and accept our Terms & Conditions and Privacy Policy")
            cell.loginviewControllerDeligate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section{
        case 0:
            let headerView = Bundle.main.loadNibNamed("LoginHeader", owner: self, options: nil)?.first as? LoginHeader
            headerView?.setHeaderLbl()
            return headerView
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return UITableView.automaticDimension
        default:
            return 0
        }
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

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let pointInTable = textField.convert(textField.bounds.origin, to: self.loginTableView)
        let textFieldIndexPath = self.loginTableView.indexPathForRow(at: pointInTable)
        if let indexPath = textFieldIndexPath {
            let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if let nextCell = self.loginTableView.cellForRow(at: nextIndexPath) {
                switch nextIndexPath.row {
                case 1:
                    (nextCell as? MobileNoTblVwCell)?.mobileNoLbl.becomeFirstResponder()
                case 2:
                    if isUserWantsReferal {
                        (nextCell as? ReferralCodeTblVwCell)?.referralCodeLbl.becomeFirstResponder()
                    }else{
                        textField.resignFirstResponder()
                    }
                default:
                    textField.resignFirstResponder()
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.text != "" else{
            return
        }
        
        switch textField.tag{
        case 1:
            if let userNameText = textField.text{
                if let userNameError = ValidationManager().userNameValidation(userName: userNameText){
                    viewModel.userNameErorr = userNameError
                    loginTableView.reloadData()
                }
            }
        case 2:
            if let mobileNoText = textField.text{
                if let mobileNoError = ValidationManager().userNameValidation(userName: mobileNoText){
                    viewModel.userNameErorr = mobileNoError
                    loginTableView.reloadData()
                }
            }
        default:
            return
        }
    }
    
    
}

extension LoginViewController : updateProceedbtnState{
    func updateProceedBtn(isActive: Bool) {
        setupProceedBtn(isActive: isActive)
    }
    
}