//
//  LoginViewController.swift
//  Founders Directory
//
//  Created by Jordan Widdison on 11/9/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

//class LoginViewController: UITableViewController, UITextViewDelegate {
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    // MARK: - Actions
    @IBAction func logIn(_ sender: Any) {
        if self.userNameField.text == "" || self.passwordField.text == "" {
            shakeUI()
            return
        }
        
        let username = self.userNameField.text
        let password = self.passwordField.text
        
        loginUser(username: username!, password: password!)
        
    }
    
    
    // MARK: - Helpers
    
    func loginUser(username: String, password: String) {
        
        let requestURL = "\(SyncHelper.Constants.baseSyncUrl)login.php?u=\(username)&p=\(password)&d=\(UIDevice.current.identifierForVendor!.uuidString)"
        
        HttpHelper.shared.getContent(urlString: requestURL) {
            (data) in
            if let usableData = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: usableData, options: .mutableContainers) as? [String: AnyObject] {
                        
                        if let sessionToken = json["sessionId"]{
                            UserDefaults.standard.set(sessionToken, forKey: SyncHelper.Constants.sessionTokenKey)
                            print("This is the token: \(sessionToken)")
                            
                            if let userID = json["userId"] {
                                UserDefaults.standard.set(userID, forKey: SyncHelper.Constants.userId)
                            }
                            
                            if let app = UIApplication.shared.delegate as? AppDelegate {
                                app.displayMainVC()
                            }
                        } else {
                            shakeUI()
                        }
                    }
                } catch {
                    print("Unable to parse JSON")
                    shakeUI()
                }
            } else {
                print("No Response Recieved")
                shakeUI()
            }
        }
    }

    
    func shakeUI() {
        let shake = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5,0,0)),
            NSValue(caTransform3D: CATransform3DMakeTranslation(5,0,0))
        ]
        shake.autoreverses = true
        shake.repeatCount = 2
        shake.duration = 7/100
        view.layer.add(shake, forKey: nil)
    }
    
    
    
    // MARK: - Table View Delegate
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        userNameField.resignFirstResponder()
//        passwordField.resignFirstResponder()
//    }
    
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        if reason == .committed {
//            // Tab to the next field
//            if textField.tag == Storyboard.tagUsername {
//                passwordField.becomesFirstResponder()
//            } else {
//                
//            }
//        }
//    }
}
