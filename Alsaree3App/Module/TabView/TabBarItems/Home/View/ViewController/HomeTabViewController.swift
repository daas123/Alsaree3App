
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
    
    //MARK: Custom Views
    let backButton = UIButton(type: .system)
    var alertView : StaticAlert!
    
    var viewModel = HomeTabViewModel()
    var headerView : HomeTabCategoryHeader?
    var refreshControl = UIRefreshControl()
    
    // For Tabbar visible/ hide
    var previousScrollOffset: CGFloat = 0
    var tabBarVisible = true
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerTableViewCell()
        settingDelegateDataSource()
        viewModel.instantiateApiCalls()
        setupTableview()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Setup UIFrames for BackButton
        let buttonY: CGFloat
        buttonY = hometabTableView.frame.origin.y + 90
        backButton.frame = CGRect(x: view.bounds.width / 2 - 50, y: buttonY, width: 100, height: 35)
        
        //Setup Static Alert
        if alertView == nil {
            let alertY: CGFloat = self.tabBarController?.tabBar.frame.origin.y ?? 0
            let nib = UINib(nibName: "StaticAlert", bundle: nil)
            alertView = nib.instantiate(withOwner: nil, options: nil).first as? StaticAlert
            alertView.frame = CGRect(x: 0, y: alertY - CGFloat(80), width: view.bounds.width, height: alertView.bounds.height)
            view.addSubview(alertView)
            alertView.isHidden = true
        }
        
    }
    
    func setupUI(){
        setupPullToRefresh()
        setUpGesture()
        hideProgressView()
        
        //setupHeaderViewUi
        setupHeaderView(headerNavigationView: headerNavigationView, applicationNamelbl: applicationNamelbl, locationLbl: locationLbl, downArrowImage: downArrowImage, scooterimg: scooterimg)
        setUpCircularprogress(circularProgresView: circularProgresView, currentProgress: 0.2, progressLbl: progressLbl)
        
        // set Back to top button
        backButton.setPropertiesWithImage(label: ButtonTextConstant.backtoTop.rawValue, image: ImageConstant.arrow_up.rawValue, textColor: UIColor.white, fontSize: 12, imageSize: CGSize(width: 15, height: 15), imagePosition: .left, imageTintColor: UIColor.white, backColor: UIColor.black, cornerRadius: 35/2)
        backButton.addTarget(self, action: #selector(scrollToFirstRow), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.isHidden = true
        
    }
    
    func settingDelegateDataSource(){
        hometabTableView.delegate = self
        hometabTableView.dataSource = self
        viewModel.homeTabDeligate = self
    }
    
    func setupTableview(){
        hometabTableView.separatorStyle = .none
        hometabTableView.backgroundColor = ColorConstant.whitecolor
        hometabTableView.sectionHeaderHeight = 0
        hometabTableView.sectionFooterHeight = 0
        if #available(iOS 15.0, *) {
            hometabTableView.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
        hometabTableView.showsVerticalScrollIndicator = false
    }
    
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        locationLbl.addGestureRecognizer(tapGesture)
    }
    
    func setupPullToRefresh(){
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        hometabTableView.addSubview(refreshControl)
    }
    
    func registerTableViewCell(){
        // MARK: Register TableViewCell
        hometabTableView.registerNib(of: ActiveOrderHomeTabCell.self)
        hometabTableView.registerNib(of: BannerHomeTabCell.self)
        hometabTableView.registerNib(of: AdvertisementCell.self)
        hometabTableView.registerNib(of: FoodCatrgoryCell.self)
        hometabTableView.registerNib(of: GoldCategoryCardCellTableViewCell.self)
        hometabTableView.registerNib(of: ResturentTableViewCell.self)
        hometabTableView.registerNib(of: ResturentDetailsTableViewCell.self)
        hometabTableView.registerNib(of: LoadingTableViewCell.self)
        hometabTableView.registerNib(of:HomeTabShimmerCell.self)
        hometabTableView.registerNib(of: StoreShimmerCell.self)
    }
    
    func hideProgressView(){
        circularProgresView.isHidden = true
        progressLbl.isHidden = true
        
    }
    
    func showProgressView(){
        circularProgresView.isHidden = false
        progressLbl.isHidden = false
    }
    
    func showCustomAlert(errorText:String){
        alertView.messageLbl.text = errorText
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
    
    func animateCellSelection(at indexPath: IndexPath) {
        if let cell = hometabTableView.cellForRow(at: indexPath) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    cell.transform = .identity
                }completion: { (_) in
                    self.pushToNextScreen(indexPath: indexPath)
                }
            }
        }
    }
    
    func pushToNextScreen(indexPath: IndexPath) {
        debugPrint(indexPath.row)
        switch indexPath.section{
        case 0:
            debugPrint("section 0")
            switch indexPath.row{
            case 0 :
                debugPrint("clicked on active ordercell")
            case 1 :
                debugPrint("clicked on banner cell")
                
            default:
                debugPrint("section 0 default")
            }
        case 1:
            debugPrint("section 1")
            switch indexPath.row{
            case 0 :
                debugPrint("section 1 row 0")
            case 1 :
                debugPrint("section 1 row 1")
            case 2 :
                debugPrint("section 1 row 2")
            case 3:
                debugPrint("section 1 row 3")
            case 4:
                debugPrint("section 1 row 4")
            default:
                let cell = hometabTableView.cellForRow(at: indexPath) as? ResturentDetailsTableViewCell
                callStoreApi(storeId: cell?.resturentDetailsTableViewCellData?._id ?? "")
            }
        case 3:
            debugPrint("section 3")
        default:
            debugPrint("default")
        }
    }
    //MARK: implimentation of BackToTop
    @objc func scrollToFirstRow() {
        let indexPath = IndexPath(row: 0, section: 0)
        self.hometabTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    //MARK: location label tap action
    @objc func labelTapped() {
        debugPrint("Location Label tapped")
    }
    
    //MARK: implimentation of pull to reload
    @objc func refreshData(_ sender: Any) {
        refreshControl.endRefreshing()
        viewModel.reloadOnPull()
    }
}

