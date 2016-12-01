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
        static let login = "login"
        static let main = "main"
    }
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        DispatchQueue.global().async {

            if UserDefaults.standard.value(forKey: SyncHelper.Constants.sessionTokenKey) != nil {
                UserDefaults.standard.set("main", forKey: Key.vc)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.set("login", forKey: Key.vc)
                UserDefaults.standard.synchronize()
            }
            
            self.updateFounderRecord()
            
            _ = SyncHelper.shared.synchronizeFounders()

            if UserDefaults.standard.string(forKey: Key.vc) == "login" {
                self.displayLoginVC()
            } else {
                self.displayMainVC()
            }
        }
        
        return true
    }
    
    // MARK: - Helpers
    
    func updateFounderRecord() {
        // NEEDSWORK: delete this test code that demonstrates how to update a record
        let userId = UserDefaults.standard.integer(forKey: SyncHelper.Constants.userId)
        
        let founder = FounderDatabase.shared.founderForId(userId)
        
        if founder.preferredFullName == "Jordan Widdison" {
            founder.preferredFullName = "Jordan the Widdison"
        } else {
            founder.preferredFullName = "Jordan Widdison"
        }
        
        founder.dirty = Int(Founder.Flag.dirty)!
        FounderDatabase.shared.update(founder)
    }
    
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
