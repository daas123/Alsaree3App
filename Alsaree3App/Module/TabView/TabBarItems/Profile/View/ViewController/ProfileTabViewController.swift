//
//  ProfileTabViewController.swift
//  Alsaree3App
//
//  Created by Neosoft on 19/12/23.
//

import UIKit

class ProfileTabViewController: BaseViewController {

    @IBOutlet weak var ProfileTabTableView: UITableView!
    @IBOutlet weak var scooterimg: UIImageView!
    @IBOutlet weak var applicationNamelbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var headerNavigationView: UIView!
    @IBOutlet weak var circularProgresView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileTabTableView.separatorStyle = .none
        setupdeligate()
        setupHeaderView(headerNavigationView: headerNavigationView, applicationNamelbl: applicationNamelbl, locationLbl: locationLbl, downArrowImage: downArrowImage, scooterimg: scooterimg)
        registerCell()
    }
    
    func setupdeligate(){
        ProfileTabTableView.delegate = self
        ProfileTabTableView.dataSource = self
    }
    
    func registerCell(){
        ProfileTabTableView.registerNib(of: ProfileBannerAdvCell.self)
        ProfileTabTableView.registerNib(of: ProfileInfoListCell.self)
    }
   
}

extension ProfileTabViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(identifier: "ProfileBannerAdvCell") as ProfileBannerAdvCell
        return cell
    }

}
