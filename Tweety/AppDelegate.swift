//
//  AppDelegate.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser != nil {
            window?.rootViewController = TweetyTabBarController()
        } else {
            let navigationController = UINavigationController(rootViewController: LoginViewController())
            window?.rootViewController = navigationController
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

