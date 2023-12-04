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
    
        configure()
    }
    
    private func configure() {
        
        setNavigationItems()
        customizeTabbar()
    }
    
    private func customizeTabbar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        changeColor(itemApperance: appearance.stackedLayoutAppearance)
        changeColor(itemApperance: appearance.compactInlineLayoutAppearance)
        changeColor(itemApperance: appearance.inlineLayoutAppearance)
        
        navigationController?.tabBarItem.standardAppearance = appearance
        navigationController?.tabBarItem.scrollEdgeAppearance = appearance
        // navigationController?.navigationBar.backgroundColor = .black
        
        tabBar.tintColor = .primaryColor
        tabBar.barTintColor = .white
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        //    tabBarController?.tabBar.standardAppearance = appearance
        //  tabBarController?.tabBar.scrollEdgeAppearance = appearance
    }
    
    func changeColor(itemApperance: UITabBarItemAppearance) {
        itemApperance.selected.iconColor = UIColor(named: "primaryColor")
    }
    
    func templateNavigationController(title: String, image: UIImage, rootViewController: UIViewController) -> UINavigationController
    {
        //view controller ların background ını ayarladık
        rootViewController.view.backgroundColor = .white
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = title.isEmpty ? image.withRenderingMode(.alwaysOriginal) : image
        
        nav.tabBarItem.title = title
        nav.navigationBar.backgroundColor = .white
        return nav
    }
    
    private func setNavigationItems() {
        
        // tabBar.tintColor = UIColor.primaryColor // Seçili olan tabın rengi
        //    tabBar.barTintColor = UIColor.gray10
        
        let homeDataProvider = HomeDataProvider()
        let homeViewController = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: .main)
        
        homeViewController.viewModel = HomeViewModel(service: homeDataProvider)
        
        let orderViewController = OrderViewController(nibName: String(describing: OrderViewController.self), bundle: .main)
        
        let cartDataProvider = CartDataProvider()
        let cartViewController = CartViewController(nibName: String(describing: CartViewController.self), bundle: .main)
        cartViewController.viewModel = CartViewModel(service: cartDataProvider)
        
        let chatViewController = ChatViewController(nibName: String(describing: ChatViewController.self), bundle: .main)
        
        let profileViewController = ProfileViewController(nibName: String(describing: ProfileViewController.self), bundle: .main)
        
        profileViewController.viewModel = ProfileViewModel()
        
        let navigationControllerHome: UINavigationController = templateNavigationController(title: "Home", image:UIImage(named:"home")!,rootViewController: homeViewController)
        
        let navigationControllerOrder: UINavigationController = templateNavigationController(title: "Order", image:UIImage(named:"task-square")!,rootViewController: orderViewController)
        
        let navigationControllerCart: UINavigationController = templateNavigationController(title: "", image:UIImage(named:"menu")!,rootViewController: cartViewController)
        
        let navigationControllerChat: UINavigationController = templateNavigationController(title: "Chat", image:UIImage(named:"message-text")!,rootViewController: chatViewController)
        
        let navigationControllerProfile: UINavigationController = templateNavigationController(title: "Profile", image:UIImage(named:"profile-circle")!,rootViewController: profileViewController)
        
        self.viewControllers = [navigationControllerHome, navigationControllerOrder, navigationControllerCart, navigationControllerChat, navigationControllerProfile]
        
        if let items = tabBar.items {
            items[0].selectedImage = UIImage(named: "home-selected")
        }
    }
    
}



