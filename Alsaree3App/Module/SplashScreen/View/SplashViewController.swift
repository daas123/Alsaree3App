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
        navigationController?.navigationBar.isHidden = true
        setupAnimation()
        viewmodel.callSplashScreeenApis()
        viewmodel.splashScreenDeligate = self
        setupObserver()
    }

    override func viewDidDisappear(_ animated: Bool) {
        animationView?.stop()
    }
    
    func setupAnimation(){
        animationView = .init(name: AnimationConstant.alsaree_animation.rawValue,subdirectory: "Animation")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView?.backgroundBehavior = .pauseAndRestore
        view.addSubview(animationView!)
        animationView!.play()
    }
    
    func setupObserver(){
        NotificationManager().addObserver(forName: .reloadData) { _ in
            self.dismiss(animated: true)
            self.viewmodel.callSplashScreeenApis()
        }
    }
}


extension SplashViewController : splashScreenActions{
    func navigateToAppSettingErrorState() {
        let storyboard = UIStoryboard(name: StoryBoardConstant.commonScreens.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: ViewControllerConstant.someThingwentWrong.rawValue) as! SomeThingwentWrong
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToInValidAreaLocation() {
        let storyboard = UIStoryboard(name: StoryBoardConstant.main.rawValue, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            self.view.window?.rootViewController = initialViewController
        }
    }
    
    func navigateToHomeTab() {
        let storyboard = UIStoryboard(name: StoryBoardConstant.main.rawValue, bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() {
            DispatchQueue.main.async {
                self.view.window?.rootViewController = initialViewController
            }
        }
    }
    
    
}
