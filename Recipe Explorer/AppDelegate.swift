//
//  AppDelegate.swift
//  Recipe Explorer
//
//  Created by Furqan on 2019-05-30.
//  Copyright © 2019 Furqan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootViewController()
        return true
    }
    
    /// Sets `RecipesViewController` as the root view controller of the app.
    private func setRootViewController() {
        // Create a navigation controller and start Recipes coordinator with it.
        let navigationController = UINavigationController()
        let coordinator = RecipesCoordinator(navigationController: navigationController)
        navigationController.setViewControllers([coordinator.start()], animated: false)
        
        // Set the navigation controller as root of the window.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
