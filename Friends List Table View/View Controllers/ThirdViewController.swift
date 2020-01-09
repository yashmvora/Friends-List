//
//  ThirdViewController.swift
//  Friends List Table View
//
//  Created by yash on 22/07/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

protocol ThirdViewControllerDelegate {
    func sendImageInfoToAddFriendTableView(image: UIImage)
}

class ThirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage?
    var friend: Friend?
    var friendEdit: Friend?
    var delegate: ThirdViewControllerDelegate?
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editButtonClicked(sender:)))
        self.navigationItem.title = "Profile Picture"
        self.navigationItem.rightBarButtonItem = rightButton
        
        if let _ = friend {
            self.navigationItem.rightBarButtonItem = nil
            imageViewOutlet.image = friend?.image
        } else {
            imageViewOutlet.image = friendEdit?.image
        }
        
    }
    
    @objc func editButtonClicked(sender: UIBarButtonItem) {
        
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.openCamera()
        }
        let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { (_) in
            self.openGallery()
        }
        let removePhoto = UIAlertAction(title: "Remove Photo", style: .destructive) { (_) in
            self.removePhoto()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheetController.addAction(takePhoto)
        actionSheetController.addAction(choosePhoto)
        actionSheetController.addAction(removePhoto)
        actionSheetController.addAction(cancelAction)
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func removePhoto() {
        if let image = UIImage(named: "ProfileImage") {
            imageViewOutlet.image = image
            delegate?.sendImageInfoToAddFriendTableView(image: image)
        }
//        friendEdit?.image = UIImage(named: "ProfileImage")
//        delegate?.sendImageInfoToSecondVC(image: UIImage(named: "ProfileImage")!)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.sourceType = .camera
            vc.allowsEditing = false
            present(vc, animated: true)
        }
    }

    func openGallery() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = false
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        imageViewOutlet.image = image
        if delegate != nil {
            delegate?.sendImageInfoToAddFriendTableView(image: image)
        }
        picker.dismiss(animated: false)
    }
}
