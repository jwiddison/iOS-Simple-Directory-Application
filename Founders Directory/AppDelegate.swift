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

    // MARK: - Constants
    
    struct Constants {
        static let vcKey = "vc"
        static let loginVCKey = "login"
        static let mainVCKey = "main"
        static let loginViewControllerName = "Login"
        static let mainViewControllerName = "Main"
        static let timerInterval = 600.00
        static let defaultSessionToken = "41471165af5bb678bf58467811505450"
    }
    
    // MARK: - Properties
    
    var window: UIWindow?
    var syncTimer: Timer!
    
    // MARK: - Application Lifecycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DispatchQueue.global().async {
            if UserDefaults.standard.value(forKey: SyncHelper.Constants.sessionTokenKey) == nil {
                UserDefaults.standard.set(Constants.defaultSessionToken, forKey: SyncHelper.Constants.sessionTokenKey)
            }
            _ = SyncHelper.shared.synchronizeFounders()
        }
        
        startSyncTimer()
        
        DispatchQueue.main.async {
            if UserDefaults.standard.value(forKey: SyncHelper.Constants.sessionTokenKey) as? String != Constants.defaultSessionToken {
                UserDefaults.standard.set(Constants.mainVCKey, forKey: Constants.vcKey)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.set(Constants.loginVCKey, forKey: Constants.vcKey)
                UserDefaults.standard.synchronize()
            }

            if UserDefaults.standard.string(forKey: Constants.vcKey) == Constants.loginVCKey {
                self.displayLoginVC()
            } else {
                self.displayMainVC()
            }
        }
        return true
    }
    
    // MARK: - Helpers
    
    func animateTransistion(to viewController: UIViewController) {
        if let currentVC = window?.rootViewController {
            viewController.view.frame = currentVC.view.frame
            viewController.view.alpha = 0
            window?.addSubview(viewController.view)
            
            UIView.animate(withDuration: 1, animations: { viewController.view.alpha = 1 }, completion: {
                (finished) in
                self.window!.rootViewController = viewController
                self.window!.makeKeyAndVisible()
            })
        } else {
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
    }
    
    func displayLoginVC() {
        let storyboard = UIStoryboard(name: Constants.loginViewControllerName, bundle: nil)
        
        if let loginVC = storyboard.instantiateInitialViewController() as? LoginViewController {
            animateTransistion(to: loginVC)
        }
        
        UserDefaults.standard.set(Constants.loginVCKey, forKey: Constants.vcKey)
        UserDefaults.standard.synchronize()
    }
    
    func displayMainVC() {
        let storyboard = UIStoryboard(name: Constants.mainViewControllerName, bundle: nil)
        
        if let mainVC = storyboard.instantiateInitialViewController() as? UINavigationController {
            animateTransistion(to: mainVC)
        }
        
        UserDefaults.standard.set(Constants.mainVCKey, forKey: Constants.vcKey)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Timer Functions
    
    func startSyncTimer(){//Runs every 10 minutes
        syncTimer = Timer.scheduledTimer(timeInterval: Constants.timerInterval, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    func runTimedCode() {
        DispatchQueue.global().async {
            _ = SyncHelper.shared.synchronizeFounders()
        }
    }
    
}
