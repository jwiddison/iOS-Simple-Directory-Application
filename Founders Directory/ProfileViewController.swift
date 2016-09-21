//
//  ProfileViewController.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class ProfileViewController : UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var spouseIndicatorLabel: UILabel!
    @IBOutlet weak var spouseNameLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var callPhoneButton: UIButton!
    @IBOutlet weak var sendTextButton: UIButton!
    @IBOutlet weak var sendEmailButton: UIButton!

    // MARK: - Properties
    
    var founder: Founder?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        Helper.applyRoundBorder(to: imageView)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? EditProfileViewController {
            destVC.founder = founder
        }
    }
    
    // MARK: - Helpers
    
    private func updateUI() {
        if let founder = self.founder {
            imageView.image = UIImage(named: founder.photoName)
            
            title = founder.name
            companyLabel.text = founder.company
            emailLabel.text = founder.emailListed ? founder.email : ""
            phoneLabel.text = founder.phoneListed ? founder.phone : ""
            
            if founder.spouseName == "" {
                spouseIndicatorLabel.isHidden = true
                spouseNameLabel.isHidden = true
            } else {
                spouseIndicatorLabel.isHidden = false
                spouseNameLabel.isHidden = false
                spouseNameLabel.text = founder.spouseName
            }
            
            profileLabel.text = founder.profile
            
            callPhoneButton.isEnabled = founder.phoneListed
            sendTextButton.isEnabled = founder.phoneListed
            sendEmailButton.isEnabled = founder.emailListed
            
            if founder.email != "chewie@gmail.com" {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }

    // MARK: - Actions
    
    @IBAction func callPhone(_ sender: UIButton) {
        if let phone = phoneLabel.text {
            if phone.characters.count > 0 {
                if let url = URL(string: "tel://\(phone)") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }

    @IBAction func sendEmail(_ sender: UIButton) {
        if let email = emailLabel.text {
            if email.characters.count > 0 {
                if let url = URL(string: "mailto://\(email)") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }

    @IBAction func sendText(_ sender: UIButton) {
        if let phone = phoneLabel.text {
            if phone.characters.count > 0 {
                if let url = URL(string: "sms://\(phone)") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
}
