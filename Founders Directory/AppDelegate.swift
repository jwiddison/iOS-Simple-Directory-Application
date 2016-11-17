//
//  AppDelegate.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    struct Key {
        static let vc = "vc"
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DispatchQueue.global().async {
            // NEEDSWORK: Replace this code
            UserDefaults.standard.set("41471165af5bb678bf58467811505450",
                                      forKey: SyncHelper.Constants.sessionTokenKey)
            UserDefaults.standard.synchronize()
            // NEEDSWORK: log in; don't hard-code the session ID

            _ = SyncHelper.shared.synchronizeFounders()
        }
        
        if UserDefaults.standard.string(forKey: Key.vc) == "login" {
            displayLoginVC()
        }

        return true
    }
    
    func animateTransistion(to viewController: UIViewController) {
        if let currentVC = window?.rootViewController {
            viewController.view.frame = currentVC.view.frame
            viewController.view.alpha = 0
            window?.addSubview(viewController.view)
            
            UIView.animate(withDuration: 1, animations: {
                viewController.view.alpha = 1
            }, completion: { (finished) in
                self.window!.rootViewController = viewController
                self.window!.makeKeyAndVisible()
            })
        } else {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
    }
    
    func displayLoginVC() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        
        if let loginVC = storyboard.instantiateInitialViewController() as? LoginViewController {
            animateTransistion(to: loginVC)
        }
        
        UserDefaults.standard.set("login", forKey: Key.vc)
        UserDefaults.standard.synchronize()
    }
    
    func displayMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let mainVC = storyboard.instantiateInitialViewController() as? UINavigationController {
            animateTransistion(to: mainVC)
        }
        
        UserDefaults.standard.set("main", forKey: Key.vc)
        UserDefaults.standard.synchronize()
    }
}
