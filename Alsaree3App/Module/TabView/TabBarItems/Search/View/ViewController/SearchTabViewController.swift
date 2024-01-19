//
//  SearchTabViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 16/12/23.
//

import UIKit
class SearchTabViewController: UIViewController{
    
    
    @IBOutlet weak var scooterimg: UIImageView!
    @IBOutlet weak var applicationNamelbl: UILabel!
    @IBOutlet weak var areaNavitionBtn: UIButton!
    @IBOutlet weak var areaNavigationView: UIView!
    @IBOutlet weak var searchtabTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingDelegate()
        registerTableViewCell()
        searchtabTableView.separatorStyle = .none
        searchtabTableView.backgroundColor = ColorConstant.primaryWhiteBgcolor
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func settingDelegate(){
        searchtabTableView.delegate = self
        searchtabTableView.dataSource = self
    }
    
    func registerTableViewCell(){
        // MARK: TableViewCell
        searchtabTableView.registerNib(of: LoadingTableViewCell.self)
    }
    
}

extension SearchTabViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(identifier: "LoadingTableViewCell") as! LoadingTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableviewSize = tableView.bounds.height
        return tableviewSize
    }
    
}
