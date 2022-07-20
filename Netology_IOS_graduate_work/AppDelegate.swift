//
//  AppDelegate.swift
//  Netology_IB_Instruments
//
//  Created by Роман Олегович on 26.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator?
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = UITabBarController()
        root.viewControllers = [SoundViewController()]
        window?.rootViewController = root
        window?.makeKeyAndVisible()
//        appCoordinator = AppCoordinator(window: window)
//        appCoordinator?.start()
        return true
    }

}

