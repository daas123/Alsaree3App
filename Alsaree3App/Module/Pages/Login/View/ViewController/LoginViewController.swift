//
//  LoginViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 25/02/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginTableView : UITableView!
    @IBOutlet weak var proceedBtnParentView: UIView!
    @IBOutlet var proceedBtn : UIButton!
    
    var isUserWantsReferal = false
    var isKeybordVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        setupDeligate()
        regTableviewCell()
        setupTableview()
        setupProceedBtn()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeybordVisible{
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.view.frame.origin.y -= 100
                isKeybordVisible = true
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.size.height = UIScreen.main.bounds.height
            isKeybordVisible = false
        }
    }

    
    func setupDeligate(){
        loginTableView.delegate = self
        loginTableView.dataSource = self
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
    
    func setupProceedBtn(){
        proceedBtnParentView.addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
        proceedBtn.setProperties(label: "Proceed",color: ColorConstant.whitecolor ,size: 18,backcolor: ColorConstant.primaryGrayBrownColor,cornerRadius: 10,tintcolor: ColorConstant.borderColorGray)
    }
    
    @IBAction func onClickProceedBtn(_ sender: UIButton) {
        
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
            return cell
        case 1:
            let cell = tableView.getCell(identifier: "MobileNoTblVwCell") as! MobileNoTblVwCell
            cell.mobileNoLbl.delegate = self
            cell.setHeadingLbl(lblText: "Mobile Number")
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

}
