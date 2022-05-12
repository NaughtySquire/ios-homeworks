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

        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        let feedVC = TabBarItem(FeedViewController(), "Feed", "newspaper.circle.fill")
        let profileVC = TabBarItem(LogInViewController(), "Profile", "person.crop.circle.fill")
        let rootVC = UITabBarController()
        rootVC.viewControllers = [profileVC, feedVC]
        rootVC.tabBar.backgroundColor = .systemBackground
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

