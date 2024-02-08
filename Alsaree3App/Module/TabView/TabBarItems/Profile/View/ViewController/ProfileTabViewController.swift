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
        
        languagelbl.setProperties(lbltext: "Language", fontSize: 16)
        setEnglishBtnSelected()
        languageSelectionView.addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
        
    }
    
    func setEnglishBtnSelected(){
        selectEnglishBtn.setProperties(label: "English", color: ColorConstant.whitecolor,size: 16,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10)
        selectArabicBtn.setProperties( label: "Arabic",color: ColorConstant.blackcolor, size: 16,borderColor:ColorConstant.borderColorGray, backcolor: ColorConstant.whitecolor,cornerRadius: 10,borderWidth: 0.5)
    }
    
    func setArabicBtnSelected(){
        selectEnglishBtn.setProperties(label: "English", color: ColorConstant.blackcolor,size: 16,borderColor:ColorConstant.borderColorGray, backcolor: ColorConstant.whitecolor,cornerRadius: 10,borderWidth: 0.5 )
        selectArabicBtn.setProperties(label: "Arabic",color: ColorConstant.whitecolor, size: 16,backcolor: ColorConstant.primaryYellowColor,cornerRadius: 10)
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
        setApplicationLanguage(languageCode: "en-US")
    }
    
    @IBAction func onClickArabicBtn(_ sender: UIButton) {
        self.setArabicBtnSelected()
        setApplicationLanguage(languageCode: "ar")
    }
    
    func setApplicationLanguage(languageCode : String)
        {
            UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
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
