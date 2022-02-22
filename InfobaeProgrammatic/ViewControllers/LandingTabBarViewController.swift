//
//  ViewController.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 24/01/2022.
//

import UIKit

class LandingTabBarViewController: UITabBarController {
    lazy var homeNewsNavigationController = NavigationController(rootViewController: homeNewsViewController)
    lazy var homeNewsViewController = HomeNewsViewController()
    
    lazy var sectionNavigationController = NavigationController(rootViewController: sectionViewController)
    lazy var sectionViewController = SectionViewController()
    
    lazy var alertNavigationController = NavigationController(rootViewController: alertViewController)
    lazy var alertViewController = AlertViewController()
    
    lazy var savedNavigationController = NavigationController(rootViewController: savedViewController)
    lazy var savedViewController = SavedViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        self.homeNewsViewController.tabBarItem = UITabBarItem.init(title: "Portada", image: UIImage(named: "home-icon"), tag: 1)
        self.sectionViewController.tabBarItem = UITabBarItem.init(title: "Secciones", image: UIImage(named: "section-icon"), tag: 2)
        self.alertViewController.tabBarItem = UITabBarItem.init(title: "Alertas", image: UIImage(named: "alert-icon"), tag: 3)
        self.savedViewController.tabBarItem = UITabBarItem.init(title: "Guardadas", image: UIImage(named: "saved-icon"), tag: 4)
        
        self.setViewControllers([homeNewsNavigationController, sectionNavigationController, alertNavigationController, savedNavigationController], animated: false)
        
        setupCustomTabBar()
    }
    
    func setupCustomTabBar() {
        self.tabBar.barTintColor = UIColor(displayP3Red: 246/255, green: 142/255, blue: 30/255, alpha: 1)
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .black
    }
}

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationBar.barTintColor = UIColor(displayP3Red: 246/255, green: 142/255, blue: 30/255, alpha: 1)
        self.navigationBar.tintColor = .black
    }
}

