//
//  ProfileTabViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 19/12/23.
//

import UIKit

class ProfileTabViewController: BaseViewController {

    //MARK: header View Outlets
    @IBOutlet weak var ProfileTabTableView: UITableView!
    @IBOutlet weak var scooterimg: UIImageView!
    @IBOutlet weak var applicationNamelbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var headerNavigationView: UIView!
    @IBOutlet weak var circularProgresView: UIView!
    @IBOutlet weak var progressLbl: UILabel!
    
    //MARK: Select language Outlets
    
    @IBOutlet weak var languageSelectionView: UIView!
    @IBOutlet weak var languagelbl: UILabel!
    @IBOutlet weak var selectEnglishBtn: UIButton!
    @IBOutlet weak var selectArabicBtn: UIButton!
    
    var viewModel = ProfileTabViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileTabTableView.separatorStyle = .none
        setupdeligate()
        setupHeaderView(headerNavigationView: headerNavigationView, applicationNamelbl: applicationNamelbl, locationLbl: locationLbl, downArrowImage: downArrowImage, scooterimg: scooterimg)
        setUpCircularprogress(circularProgresView: circularProgresView, currentProgress: 0.2, progressLbl: progressLbl)
        registerCell()
        setupUi()
        hideProgressView()
    }
    
    func setupUi(){
        view.setLabelText(lblrefrence: languagelbl, lbltext: "Language", fontSize: 16)
        setEnglishBtnSelected()
        languageSelectionView.addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
    }
    
    func setEnglishBtnSelected(){
        view.setButtonText(button: selectEnglishBtn, label: "English", color: ColorConstant.whitecolor,size: 16,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10)
        view.setButtonText(button: selectArabicBtn, label: "Arabic",color: ColorConstant.blackcolor, size: 16,backcolor: ColorConstant.whitecolor,cornerRadius: 10)
        selectArabicBtn.layer.borderWidth = 0.5
        selectArabicBtn.layer.borderColor = ColorConstant.borderColorGray.cgColor
    }
    
    func setArabicBtnSelected(){
        view.setButtonText(button: selectEnglishBtn, label: "English", color: ColorConstant.blackcolor,size: 16,backcolor: ColorConstant.whitecolor,cornerRadius: 10)
        view.setButtonText(button: selectArabicBtn, label: "Arabic",color: ColorConstant.whitecolor, size: 16,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10)
        selectEnglishBtn.layer.borderWidth = 0.5
        selectEnglishBtn.layer.borderColor = ColorConstant.borderColorGray.cgColor
    }
    
    func setupdeligate(){
        ProfileTabTableView.delegate = self
        ProfileTabTableView.dataSource = self
    }
    
    func registerCell(){
        ProfileTabTableView.registerNib(of: ProfileBannerAdvCell.self)
        ProfileTabTableView.registerNib(of: ProfileInfoListCell.self)
    }
    
    func hideProgressView(){
        circularProgresView.isHidden = true
        progressLbl.isHidden = true
    }
    
    @IBAction func onClickEnglishbtn(_ sender: UIButton) {
        self.setEnglishBtnSelected()
    }
    
    @IBAction func onClickArabicBtn(_ sender: UIButton) {
        self.setArabicBtnSelected()
    }
    
}

extension ProfileTabViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTableViewCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0 :
            let cell = tableView.getCell(identifier: "ProfileBannerAdvCell") as ProfileBannerAdvCell
            return cell
        case 1 :
            let cell = tableView.getCell(identifier: "ProfileInfoListCell") as ProfileInfoListCell
            cell.listDetails = profiletabDemoData[0]
            cell.setupUi()
            return cell
        default :
            let cell = tableView.getCell(identifier: "ProfileInfoListCell") as ProfileInfoListCell
            cell.listDetails = profiletabDemoData[indexPath.row - 1]
            cell.setupUi()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
