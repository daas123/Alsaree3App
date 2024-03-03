//
//  UIViewController+Extension.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 01/03/24.
//

import UIKit
extension UIViewController{
    func customPresent(storyboard:String = "Main",viewController:UIViewController,presentingHeigth:CGFloat) -> PresentationController{
        let presentationController = PresentationController(presentedViewController: viewController, presenting: self, customHeight: presentingHeigth)
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = presentationController
        return presentationController
    }
}

