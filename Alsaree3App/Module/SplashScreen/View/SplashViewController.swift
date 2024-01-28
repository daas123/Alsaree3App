//
//  SplashViewController.swift
//  Alsaree3App
//
//  Created by Neosoft1 on 28/01/24.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var animationviewLayout: UIView!
    
    private var animationView: LottieAnimationView?
    var viewmodel = SplashScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        setupAnimation()
        viewmodel.splashScreenDeligate = self
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        animationView?.stop()
    }
    
    func callApi(){
        viewmodel.callSplashScreeenApis()
    }
    
    func setupAnimation(){
        animationView = .init(name: "alsaree_animation",subdirectory: "Animation")
        animationView!.frame = animationviewLayout.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView?.backgroundBehavior = .pauseAndRestore
        animationviewLayout.addSubview(animationView!)
        animationView!.play()
    }
}


extension SplashViewController : splashScreenActions{
    func navigateToAppSettingErrorState() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
        }
    }
    
    func navigateToInValidAreaLocation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
        }
    }
    
    func navigateToHomeTab() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
        }
    }
    
    
}
