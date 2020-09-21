//
//  AppDelegate.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 19/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    
    
    // MARK: - UIApplicationDelegate Lifecycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupInitialVC()
        return true
    }
    
    private func setupInitialVC(){
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let landingVC = UMLandingVC()
        self.window?.rootViewController =
            UINavigationController(rootViewController: landingVC)
        self.window?.makeKeyAndVisible()
        
    }
    
    
}

