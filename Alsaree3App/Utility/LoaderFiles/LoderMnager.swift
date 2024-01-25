//
//  LoaderManager.swift
//  Alsaree3App
//
//  Created by Neosoft on 20/12/23.
//
import UIKit

class LoaderManager {
    static var shared = LoaderManager()
    private init() {}
    
    private let activityIndicator = ActivityIndicatorAnimationBallClipRotateMultiple()
    private var loaderView: UIView?

    func showLoading(on view: UIView? = nil,backgroundColor : UIColor = UIColor.clear) {
        DispatchQueue.main.async {
            let parentView = view ?? UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.loaderView = UIView(frame: parentView?.bounds ?? CGRect.zero)
            self.loaderView?.backgroundColor = backgroundColor
            parentView?.addSubview(self.loaderView!)
            
            guard let layer = self.loaderView?.layer else { return }
            
            self.activityIndicator.setUpAnimation(
                in: layer,
                size: CGSize(width: 30, height: 30),
                color: ColorConstant.primaryYellowColor
            )
            
            self.loaderView?.center = parentView?.center ?? CGPoint.zero
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
        }
    }
}


//UIColor.black.withAlphaComponent(0.5)
