//
//  MainTabBarController.swift
//  IGListKitArchetype
//
//  Created by 陳囿豪 on 2019/6/2.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import UIKit
import PKCHelper

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViewController()
    }
    
    fileprivate func setupViewController() {
        
        // Login
        let loginController = LoginViewController()
        loginController.title = "Login"
        let navLoginController = templateNavController(image: nil, rootViewController: loginController, selectImage: nil)
        
        // SignUp
        
         let signUpController = SignUpViewController()
        signUpController.title = "SignUp"
        let navSignUpController = templateNavController(image: nil, rootViewController: signUpController, selectImage: nil)
        
        // Products
        
        let productsViewController = ProductsViewController()
        productsViewController.title = "Products"
        let navProductsViewController = templateNavController(image: nil, rootViewController: productsViewController, selectImage: nil)
        
        // tabBar
        
        // tabBar.tintColor = UIColor.reddishOrange
        tabBar.unselectedItemTintColor = .brownishGrey
        
        viewControllers = [
            navLoginController,
            navSignUpController,
            navProductsViewController
        ]
        
    }
    
    fileprivate func templateNavController(image: UIImage?, rootViewController: UIViewController = UIViewController(), selectImage: UIImage? = nil) -> UINavigationController {
        
        let viewNavController = UINavigationController(rootViewController: rootViewController)
        
        if let image = image {
            viewNavController.tabBarItem.image = image
        }
        
        if let selectImage = selectImage {
            viewNavController.tabBarItem.selectedImage = selectImage
        }
        
        return viewNavController
    }
    
}
