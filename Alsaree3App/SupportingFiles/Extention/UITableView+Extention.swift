//
//  UITableView+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/01/24.
//

import Foundation
import UIKit
extension UITableViewCell{
    func showErrorMessage(nameNib:String, uiView:UIView) {
        if let customErrorView = loadErrorViewFromNib(nibName:nameNib) {
            uiView.addSubview(customErrorView)
            customErrorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customErrorView.topAnchor.constraint(equalTo: uiView.topAnchor),
                customErrorView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
                customErrorView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
                customErrorView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
            ])
        }
    }
    
    func loadErrorViewFromNib(nibName:String) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
}
