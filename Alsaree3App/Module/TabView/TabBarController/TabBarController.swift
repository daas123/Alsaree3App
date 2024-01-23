//
//  TabBarController.swift
//  Alsaree3App
//
//  Created by Neosoft on 15/12/23.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupBorder()
        self.delegate = self
    }
    func setupBorder() {
        tabBar.addTopBorderWithColor(color: ColorConstant.borderColorGray, width: 1.0)
    }
    
    //MARK: Creating the tab bar bounce
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            guard let idx = tabBar.items?.firstIndex(of: item), tabBar.subviews.count > idx + 1, let imageView = tabBar.subviews[idx + 1].subviews.first as? UIImageView else {
                return
            }
            imageView.layer.add(bounceAnimation, forKey: nil)
        }

    //MARK: Creaiting the View Bounce
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            viewController.view.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: {
                    viewController.view.transform = .identity
                },
                completion: nil
            )
        }
        

    func setupTabBar(){
        let normalTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ColorConstant.blackcolor,
            .font: UIFont(name: FontConstant.regular.rawValue, size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ColorConstant.primaryYellowColor,
            .font: UIFont(name: FontConstant.bold.rawValue, size: 10) ?? UIFont.systemFont(ofSize: 10)
        ]
        
        // Set the unselected text color and image color
        UITabBarItem.appearance().setTitleTextAttributes(normalTextAttributes, for: .normal)
        UITabBar.appearance().unselectedItemTintColor = ColorConstant.blackcolor
        
        // Set the selected text color and image color
        UITabBarItem.appearance().setTitleTextAttributes(selectedTextAttributes, for: .selected)
        UITabBar.appearance().tintColor = ColorConstant.primaryYellowColor
        
        // Customize individual tab bar items (replace with your own images and titles)
        if let items = tabBar.items {
            items[0].selectedImage = UIImage(named: TabBar.Home.imageName)?.withRenderingMode(.alwaysTemplate)
            items[0].image = UIImage(named: TabBar.Home.imageName)?.withRenderingMode(.alwaysTemplate)
            items[0].title = TabBar.Home.rawValue
            
            items[1].selectedImage = UIImage(named: TabBar.Search.imageName)?.withRenderingMode(.alwaysTemplate)
            items[1].image = UIImage(named: TabBar.Search.imageName)?.withRenderingMode(.alwaysTemplate)
            items[1].title = TabBar.Search.rawValue
            
            items[2].selectedImage = UIImage(named: TabBar.Profile.imageName)?.withRenderingMode(.alwaysTemplate)
            items[2].image = UIImage(named: TabBar.Profile.imageName)?.withRenderingMode(.alwaysTemplate)
            items[2].title = TabBar.Profile.rawValue
            
            items[3].selectedImage = UIImage(named: TabBar.Basket.imageName)?.withRenderingMode(.alwaysTemplate)
            items[3].image = UIImage(named: TabBar.Basket.imageName)?.withRenderingMode(.alwaysTemplate)
            items[3].title = TabBar.Basket.rawValue
        }
    }
}
