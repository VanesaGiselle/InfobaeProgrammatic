//
//  AppDelegate.swift
//  InfobaeProgrammatic
//
//  Created by Vanesa Korbenfeld on 24/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool     {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LandingTabBarViewController()
        window?.makeKeyAndVisible()
        return true
    }
}


