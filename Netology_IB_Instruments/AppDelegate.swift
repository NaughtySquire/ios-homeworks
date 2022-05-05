//
//  AppDelegate.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 26.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let feedVC = TabBarItem(FeedViewController(), "Лента", "newspaper.circle.fill")
        let profileVC = TabBarItem(ProfileViewController(), "Профиль", "person.crop.circle.fill")
        let rootVC = UITabBarController()
        
        rootVC.viewControllers = [feedVC, profileVC]
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

