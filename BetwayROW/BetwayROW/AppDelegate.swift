//
//  AppDelegate.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/10.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureNavigationBar()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

extension AppDelegate {
    static var rootViewController: UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
}

extension AppDelegate {
    fileprivate func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBar.appearance()
        
        navigationBarAppearance.tintColor = .white
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.barStyle = .default
        navigationBarAppearance.barTintColor = .black
    }
}

