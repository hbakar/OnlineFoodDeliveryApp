//
//  MainTabController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit

 class MainTabController: UITabBarController,UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    private func configure() {
       setNavigationItems()
       customizeTabbar()
        
   }
     
    private func customizeTabbar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemIndigo
        changeColor(itemApperance: appearance.stackedLayoutAppearance)
        changeColor(itemApperance: appearance.compactInlineLayoutAppearance)
        changeColor(itemApperance: appearance.inlineLayoutAppearance)
        
        
       tabBarController?.tabBar.standardAppearance = appearance
       tabBarController?.tabBar.scrollEdgeAppearance = appearance
    }
    
     func changeColor(itemApperance: UITabBarItemAppearance) {
         itemApperance.selected.iconColor = UIColor(named: "primaryColor")
     }
    
     func templateNavigationController(title: String, image: UIImage, rootViewController: UIViewController) -> UINavigationController
     {
         let nav = UINavigationController(rootViewController: rootViewController)
         nav.tabBarItem.image = title.isEmpty ? image.withRenderingMode(.alwaysOriginal) : image
         nav.tabBarItem.title = title
         nav.navigationBar.backgroundColor = .blue
         nav.tabBarController?.tabBar.backgroundColor = .red
         return nav
     }
    
    private func setNavigationItems() {
        
        let homeDataProvider = HomeDataProvider()
        
        let homeViewController = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: .main)
        
        homeViewController.viewModel = HomeViewModel(service: homeDataProvider)
        
        let orderViewController = OrderViewController(nibName: String(describing: OrderViewController.self), bundle: .main)
        
        
        let cartDataProvider = CartDataProvider()
        let cartViewController = CartViewController(nibName: String(describing: CartViewController.self), bundle: .main)
        cartViewController.viewModel = CartViewModel(service: cartDataProvider)
        
        let chatViewController = ChatViewController(nibName: String(describing: ChatViewController.self), bundle: .main)
        
        let profileViewController = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: .main)
        
        let navigationControllerHome: UINavigationController = templateNavigationController(title: "Home", image:UIImage(named:"home")!,rootViewController: homeViewController )
        
        let navigationControllerOrder: UINavigationController = templateNavigationController(title: "Order", image:UIImage(named:"task-square")!,rootViewController: orderViewController)
        
        let navigationControllerCart: UINavigationController = templateNavigationController(title: "", image:UIImage(named:"menu")!,rootViewController: cartViewController)
        
        let navigationControllerChat: UINavigationController = templateNavigationController(title: "Chat", image:UIImage(named:"message-text")!,rootViewController: chatViewController)
        
        let navigationControllerProfile: UINavigationController = templateNavigationController(title: "Profile", image:UIImage(named:"profile-circle")!,rootViewController: profileViewController)
        
       
        self.setViewControllers([navigationControllerHome, navigationControllerOrder, navigationControllerCart, navigationControllerChat, navigationControllerProfile], animated: true)
    }
     
}

extension UIImage {
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }
}


