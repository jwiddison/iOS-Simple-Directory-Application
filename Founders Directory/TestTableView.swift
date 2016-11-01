//
//  TestTableView.swift
//  Founders Directory
//
//  Created by Steve Liddle on 9/21/16.
//  Copyright © 2016 Steve Liddle. All rights reserved.
//

import UIKit

class TestTableView : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "founder2")
    }

    @IBAction func takePhoto(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        var sourceType: UIImagePickerControllerSourceType = .photoLibrary
        
//        if sender.titleLabel?.text == Storyboard.TakePhotoLabel {
//            sourceType = .camera
//        }
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePicker.delegate = self
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        dismiss(animated: true)
    }
}
