//
//  TweetyTabBarController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class TweetyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: FeedViewController(), title: "Feed", image: UIImage(systemName: "house.fill")!),
            createNavController(for: ShareViewController(), title: "Share", image: UIImage(systemName: "pencil.circle.fill")!),
            createNavController(for: AccountViewController(), title: "Account", image: UIImage(systemName: "person.circle.fill")!),
        ]
    }

    func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}
