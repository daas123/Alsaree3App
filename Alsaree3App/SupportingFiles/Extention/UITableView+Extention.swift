//
//  UITableView+Extention.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/01/24.
//

import Foundation
import UIKit
extension UITableViewCell{
    func showErrorMessage(nameNib:String, uiView:UIView, parentView:inout UIView) {
        parentView = loadErrorViewFromNib(nibName:nameNib) ?? UIView()
        uiView.addSubview(parentView)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: uiView.topAnchor),
            parentView.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
            parentView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            parentView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor)
        ])
        
        
    }
    
    func loadErrorViewFromNib(nibName:String) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as? UIView
    }
    
}
