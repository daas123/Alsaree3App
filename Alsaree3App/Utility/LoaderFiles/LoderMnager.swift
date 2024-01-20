//
//  LoaderManager.swift
//  Alsaree3App
//
//  Created by Neosoft on 20/12/23.
//
import UIKit

class LoaderManager {
    private static let activityIndicator = ActivityIndicatorAnimationBallClipRotateMultiple()
    private static var loaderView: UIView?

    class func showLoading(on view: UIView? = nil,backgroundColor : UIColor = UIColor.clear) {
        let parentView = view ?? UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        loaderView = UIView(frame: parentView?.bounds ?? CGRect.zero)
        loaderView?.backgroundColor = backgroundColor
        parentView?.addSubview(loaderView!)

        guard let layer = loaderView?.layer else { return }

        activityIndicator.setUpAnimation(
            in: layer,
            size: CGSize(width: 30, height: 30),
            color: ColorConstant.primaryYellowColor
        )

        loaderView?.center = parentView?.center ?? CGPoint.zero
    }

    class func hideLoader() {
        DispatchQueue.main.async {
            loaderView?.removeFromSuperview()
            loaderView = nil
        }
    }
}


//UIColor.black.withAlphaComponent(0.5)
