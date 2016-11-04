//
//  EditProfileViewController.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class EditProfileViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Constants
    
    private struct Storyboard {
        static let TakePhotoLabel = "Take Photo"
    }

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var companyText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var spouseText: UITextField!
    @IBOutlet weak var emailPrivateSwitch: UISwitch!
    @IBOutlet weak var phonePrivateSwitch: UISwitch!
    @IBOutlet weak var profileText: UITextView!
    
    // MARK: - Properties
    
    var founder: Founder?
    
    // MARK: - View controller lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
        navigationController?.resetBarTransparency()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.applyCircleMask()
    }

    // MARK: - Helpers
    
    @objc
    private func updateUI() {
        if let founder = self.founder {
            imageView.image = UIImage(named: founder.imageUrl)
            nameText.text = founder.preferredFullName
            companyText.text = founder.organizationName
            emailText.text = founder.email
            phoneText.text = founder.cell
            spouseText.text = founder.spousePreferredFullName
            emailPrivateSwitch.isOn = !founder.isEmailListed
            phonePrivateSwitch.isOn = !founder.isPhoneListed
            profileText.text = founder.biography
        }
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameText.resignFirstResponder()
        companyText.resignFirstResponder()
        emailText.resignFirstResponder()
        phoneText.resignFirstResponder()
        spouseText.resignFirstResponder()
        profileText.resignFirstResponder()
    }

    // MARK: - Actions
    
    @IBAction func selectImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        var sourceType: UIImagePickerControllerSourceType = .photoLibrary

        if sender.titleLabel?.text == Storyboard.TakePhotoLabel {
            sourceType = .camera
        }

        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }
    }
    
    // MARK: - Image picker controller delegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        dismiss(animated: true)
    }
}
