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
    
    private struct Constants {
        static let returnSegueIdentifier = "saveChanges"
    }

    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var nicknameText: UITextField!
    @IBOutlet weak var companyText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var spouseText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    @IBOutlet weak var yearJoinedText: UITextField!
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
            if let photo = PhotoManager.shared.getPhotoFor(founderId: founder.id) {
                imageView.image = photo
            }
            nameText.text = founder.preferredFullName
            nicknameText.text = founder.preferredFirstName
            companyText.text = founder.organizationName
            emailText.text = founder.email
            phoneText.text = founder.cell
            spouseText.text = founder.spousePreferredFullName
            statusText.text = founder.status
            yearJoinedText.text = founder.yearJoined
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
    
    @IBAction func saveChangesToFounder(_ sender: Any) {
        
        let userId = UserDefaults.standard.integer(forKey: SyncHelper.Constants.userId)
        let founder = FounderDatabase.shared.founderForId(userId)
        
        if let profilePhoto = self.imageView.image {
            PhotoManager.shared.savePhotoFor(founderId: userId, photo: profilePhoto)
            if let url = PhotoManager.shared.urlForFileName("founder\(founder.id)") {
                founder.imageUrl = url
            }
        }
        if let name = self.nameText.text {
            if name != founder.preferredFullName {
                founder.preferredFullName = name
            }
        }
        if let nickname = self.nicknameText.text {
            if nickname != founder.preferredFirstName {
                founder.preferredFirstName = nickname
            }
        }
        if let company = self.companyText.text {
            if company != founder.organizationName {
                founder.organizationName = company
            }
        }
        if let email = self.emailText.text {
            if email != founder.email {
                founder.email = email
            }
        }
        if let cell = self.phoneText.text {
            if cell != founder.cell {
                founder.cell = cell
            }
        }
        if let spouseName = self.spouseText.text {
            if spouseName != founder.spousePreferredFullName {
                founder.spousePreferredFullName = spouseName
            }
        }
        if let status = self.statusText.text {
            if status != founder.status {
                founder.status = status
            }
        }
        if let yearJoined = self.yearJoinedText.text {
            if yearJoined != founder.yearJoined {
                founder.yearJoined = yearJoined
            }
        }
        
        founder.isEmailListed = !emailPrivateSwitch.isOn
        founder.isPhoneListed = !phonePrivateSwitch.isOn
        
        if let bio = self.profileText.text {
            if bio != founder.biography {
                founder.biography = bio
            }
        }
        
        founder.dirty = Int(Founder.Flag.dirty)!
        FounderDatabase.shared.update(founder)
        
        DispatchQueue.global().async {
            _ = SyncHelper.shared.synchronizeFounders()
        }

        self.founder = founder
        
        self.performSegue(withIdentifier: Constants.returnSegueIdentifier, sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ProfileViewController {
            destVC.founder = founder
            destVC.updateUI()
            destVC.tableView.reloadData()
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
