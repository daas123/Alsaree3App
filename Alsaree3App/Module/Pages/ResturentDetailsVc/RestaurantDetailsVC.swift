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
        view.setImageOnButton(button: popButton, image: "arrowleft")
        view.setImageOnButton(button: bookMarkBtn, image: "Bookmark")
        view.setImageOnButton(button: shareBtn, image: "share")
        view.setImageOnButton(button: cartBtn, image: "bag")
    }
    
    @IBAction func onPopButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    

}
