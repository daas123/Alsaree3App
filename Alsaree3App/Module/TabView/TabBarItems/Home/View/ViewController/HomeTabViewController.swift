
//
//  HomeTabViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 15/12/23.
//

import UIKit
class HomeTabViewController: BaseViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var scooterimg: UIImageView!
    @IBOutlet weak var applicationNamelbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var hometabTableView: UITableView!
    @IBOutlet weak var headerNavigationView: UIView!
    @IBOutlet weak var circularProgresView: UIView!
    @IBOutlet weak var progressLbl: UILabel!
    
    let backButton = UIButton(type: .system)
    var circularProgressView: CircularProgressView!
    var viewModel = HomeTabViewModel()
    var headerView : HomeTabCategoryHeader?
    var refreshControl = UIRefreshControl()
    
    // For Tabbar visible/ hide
    var previousScrollOffset: CGFloat = 0
    var tabBarVisible = true
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        viewModel.homeTabDeligate = self
        viewModel.checkLocationAccess()
        settingDelegate()
        setupTableview()
        registerTableViewCell()
        setupUI()
        setupHeaderView()
        hideProgressView()
        setUpCircularprogress(currentProgress: 0.2)
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        hometabTableView.addSubview(refreshControl)
    }
    
    func setupTableview(){
        hometabTableView.separatorStyle = .none
        hometabTableView.backgroundColor = ColorConstant.primaryWhiteBgcolor
        hometabTableView.sectionHeaderHeight = 0
        hometabTableView.sectionFooterHeight = 0
        if #available(iOS 15.0, *) {
            hometabTableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        hometabTableView.showsVerticalScrollIndicator = false
    }
    
    func settingDelegate(){
        hometabTableView.delegate = self
        hometabTableView.dataSource = self
    }
    
    func registerTableViewCell(){
        // MARK: TableViewCell
        hometabTableView.registerNib(of: ActiveOrderHomeTabCell.self)
        hometabTableView.registerNib(of: BannerHomeTabCell.self)
        hometabTableView.registerNib(of: CategoryHomeTabCell.self)
        hometabTableView.registerNib(of: AdvertisementCell.self)
        hometabTableView.registerNib(of: FoodCatrgoryCell.self)
        hometabTableView.registerNib(of: GoldCategoryCardCellTableViewCell.self)
        hometabTableView.registerNib(of: ResturentTableViewCell.self)
        hometabTableView.registerNib(of: ResturentDetailsTableViewCell.self)
        hometabTableView.registerNib(of: LoadingTableViewCell.self)
        hometabTableView.registerNib(of:HomeTabShimmerCell.self)
    }
    
    func setupHeaderView(){
        headerNavigationView.backgroundColor = ColorConstant.whitecolor
        headerNavigationView.addBottomBorderWithColor(color: ColorConstant.borderColorGray, width: 1)
        
        // Setting the label and button values Manually
        view.setLabelText(lblrefrence: applicationNamelbl, lbltext: TextConstant.alsaree3App.rawValue, fontSize: 16,alignmentLeft: true)
        view.setLabelText(lblrefrence: locationLbl, lbltext: TextConstant.alFurjanArea.rawValue, fontSize: 12,lineHeightMultiple: 0.8)
        view.setImage(imageView: downArrowImage, imageName: ImageConstant.downArrow.rawValue)
        view.setImage(imageView: scooterimg, imageName: ImageConstant.scooter.rawValue)
        view.setCircleWithBorderColor(imageView: scooterimg, borderColor: ColorConstant.borderColorYellow, borderWidth: 1)
    }
    
    func setUpCircularprogress(currentProgress: Float){
        circularProgresView.layer.cornerRadius = (circularProgresView.bounds.width + 4)/2
        circularProgresView.backgroundColor = UIColor.clear
        
        // Adding the Frame
        circularProgressView = CircularProgressView(frame: circularProgresView.bounds, lineWidth: 2, rounded: true)
        circularProgressView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        //Adding color to Progress view
        circularProgressView.progressColor = ColorConstant.primaryYellowColor
        circularProgressView.trackColor = ColorConstant.borderColorGray
        
        circularProgresView.addSubview(circularProgressView)
        
        // for demo Added some Value
        circularProgressView.setProgress(to: currentProgress)
        let percentage = Int(currentProgress * 100)
        view.setLabelText(lblrefrence: progressLbl, lbltext: "\(percentage)%", fontSize: 12)
        
    }
    
    func setupObserver(){
        NotificationManager().addObserver(forName: .reloadData) { _ in
            self.dismiss(animated: true)
            self.viewModel.checkLocationAccess()
        }
    }
    
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
        // set Back to top button
        view.setButtonWithTextAndImage(button: backButton, label: ButtonTextConstant.backtoTop.rawValue, image: ImageConstant.arrow_up.rawValue, textColor: UIColor.white, fontSize: 12, imageSize: CGSize(width: 15, height: 15),imagePosition: .left,imageTintColor: UIColor.white,backColor: UIColor.black,cornerRadius: 35/2)
        
        backButton.addTarget(self, action: #selector(scrollToFirstRow), for: .touchUpInside)
        let buttonY : CGFloat?
        if UIScreen.main.bounds.height > 900 {
            buttonY = hometabTableView.frame.origin.y + 170 + 82
        }else if UIScreen.main.bounds.height > 700 {
            buttonY = hometabTableView.frame.origin.y + 170 + 25
        }else{
            buttonY = hometabTableView.frame.origin.y + 70
        }
        backButton.frame = CGRect(x: view.bounds.width / 2 - 50, y: buttonY!, width: 100, height: 35)
        view.addSubview(backButton)
        
        backButton.isHidden = true
    }
    
    func hideProgressView(){
        circularProgresView.isHidden = true
        progressLbl.isHidden = true
        
    }
    
    func showProgressView(){
        circularProgresView.isHidden = false
        progressLbl.isHidden = false
    }
    
    func callHomeScreenApi(){
        self.hometabTableView.reloadData()
    }
    
    @objc func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.hometabTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func animateCellSelection(at indexPath: IndexPath) {
        if let cell = hometabTableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    cell.transform = .identity
                }completion: { (_) in
                    //                    self.pushToNextScreen(indexPath: indexPath)
                }
            }
        }
    }
    
    func pushToNextScreen(indexPath: IndexPath) {
        let newViewController = storyboard?.instantiateViewController(withIdentifier: ViewControllerConstant.restaurantDetailsVC.rawValue) as! RestaurantDetailsVC
        viewModel.activeOrder = true
        newViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: .reloadData, object: nil)
    }
    
}

//MARK: implimentation of pull to reload
extension HomeTabViewController{
    @objc func refreshData(_ sender: Any) {
        refreshControl.endRefreshing()
        viewModel.reloadOnPull()
    }
}
