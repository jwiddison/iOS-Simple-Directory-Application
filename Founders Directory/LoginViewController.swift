//
//  LoginViewController.swift
//  Founders Directory
//
//  Created by Jordan Widdison on 11/9/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

//class LoginViewController: UITableViewController, UITextViewDelegate {
class LoginViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    // MARK: - Actions
    @IBAction func logIn(_ sender: Any) {
        if let app = UIApplication.shared.delegate as? AppDelegate {
            app.displayMainVC()
        }
    }
    
    
    
    // MARK: - Table View Delegate
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        userNameField.resignFirstResponder()
//        passwordField.resignFirstResponder()
//    }
    
    
    // MARK: - Text Field Delegate
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return notEmpty(textField)
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        if reason == .committed {
//            if textField.tag == Storyboard.tagUsername {
//                passwordField.becomesFirstResponder()
//            } else {
//                
//            }
//        }
//    }
}
