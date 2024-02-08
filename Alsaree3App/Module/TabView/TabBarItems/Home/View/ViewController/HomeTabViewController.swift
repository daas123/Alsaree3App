
//
//  HomeTabViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 15/12/23.
//

import UIKit
class HomeTabViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var headerNavigationView: UIView!
    @IBOutlet weak var circularProgresView: UIView!
    @IBOutlet weak var applicationNamelbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var scooterimg: UIImageView!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var hometabTableView: UITableView!
    
    let backButton = UIButton(type: .system)
    var viewModel = HomeTabViewModel()
    var headerView : HomeTabCategoryHeader?
    var refreshControl = UIRefreshControl()
    
    // For Tabbar visible/ hide
    var previousScrollOffset: CGFloat = 0
    var tabBarVisible = true
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegateDataSource()
        viewModel.instantiateApiCalls()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let buttonY: CGFloat
        buttonY = hometabTableView.frame.origin.y + 80
        backButton.frame = CGRect(x: view.bounds.width / 2 - 50, y: buttonY, width: 100, height: 35)
    }
    
    func setUpDelegateDataSource(){
        hometabTableView.delegate = self
        hometabTableView.dataSource = self
        
        viewModel.homeTabDeligate = self
    }
    
    func setupUI(){
        setupObserver()
        registerTableViewCell()
        setUpCircularprogress(circularProgresView: circularProgresView, currentProgress: 0.2, progressLbl: progressLbl)
        setupPulltoRelaod()
        setUpGesture()
        
        //SetupHeaderUi
        setupHeaderView(headerNavigationView: headerNavigationView, applicationNamelbl: applicationNamelbl, locationLbl: locationLbl, downArrowImage: downArrowImage, scooterimg: scooterimg)
        
        //setupBackButtonUI
        backButton.setPropertiesWithImage(label: ButtonTextConstant.backtoTop.rawValue, image: ImageConstant.arrow_up.rawValue, textColor: UIColor.white, fontSize: 12, imageSize: CGSize(width: 15, height: 15), imagePosition: .left, imageTintColor: UIColor.white, backColor: UIColor.black, cornerRadius: 35/2)
        backButton.addTarget(self, action: #selector(scrollToFirstRow), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.isHidden = true
    }
    
    func setupObserver(){
        NotificationManager().addObserver(forName: .reloadData) { _ in
            self.dismiss(animated: true)
            self.viewModel.instantiateApiCalls()
        }
    }
    
    func registerTableViewCell(){
        // MARK: Register TableViewCell
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
    
    func setupPulltoRelaod(){
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        hometabTableView.addSubview(refreshControl)
    }
    
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        applicationNamelbl.addGestureRecognizer(tapGesture)
    }
    
    func hideProgressView(){
        circularProgresView.isHidden = true
        progressLbl.isHidden = true
        
    }
    
    func showProgressView(){
        circularProgresView.isHidden = false
        progressLbl.isHidden = false
    }
    
    @objc func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.hometabTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @objc func labelTapped() {
        debugPrint("Location Label tapped")
    }
    
    @objc func refreshData(_ sender: Any) {
        refreshControl.endRefreshing()
        viewModel.reloadOnPull()
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
