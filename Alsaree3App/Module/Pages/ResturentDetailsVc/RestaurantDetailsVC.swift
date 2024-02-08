//
//  RestaurantDetailsVC.swift
//  Alsaree3App
//
//  Created by Neosoft on 29/12/23.
//

import UIKit

class RestaurantDetailsVC: UIViewController {

    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var bookMarkBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        popButton.setImageOnButton(image: "arrowleft")
        bookMarkBtn.setImageOnButton(image: "Bookmark")
        shareBtn.setImageOnButton(image: "share")
        cartBtn.setImageOnButton(image: "bag")
    }
    
    @IBAction func onPopButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    

}
