//
//  CellErrorHandlingView.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/01/24.
//

import UIKit

class CellErrorHandlingView: UIView {
    
    @IBOutlet weak var onRetryBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func OnRetryClick(_ sender: UIButton) {
        print("hello")
    }
}
