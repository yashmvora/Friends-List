//
//  AddFriendTableViewController.swift
//  Friends List Table View
//
//  Created by yash on 25/07/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

protocol AddFriendViewControllerDelegate {
    func addFriendDidCancel(_ controller: AddFriendTableViewController)
    func addFriendViewController(_ controller: AddFriendTableViewController, didFinishAdding friend: Friend)
    func addFriendViewController(_ controller: AddFriendTableViewController, didFinishEditing friend: Friend)
}

class AddFriendTableViewController: UIViewController {
    
    var friendToEdit: Friend?
    var delegate: AddFriendViewControllerDelegate?
    var didSelectImage: Bool = false
    var pickOption = ["Real Estate Broker", "Sales Representatives", "Designer", "Programmer", "Dectective", "Chef", "Inspector", "Shopkeeper", "Director", "Investor"]
    var datePicker: UIDatePicker?
    var activeTextField: UITextField?
    var keyboardHeight: CGFloat = 253
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var occupationTextfield: UITextField!
    @IBOutlet weak var dateOfBirthTextfield: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var imageAlertLabel: UILabel!
    @IBOutlet weak var nameAlertLabel: UILabel!
    @IBOutlet weak var occupationAlertLabel: UILabel!
    @IBOutlet weak var descriptionAlertLabel: UILabel!
    @IBOutlet weak var dateOfBirthAlertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        dateOfBirthTextfield.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        occupationTextfield.inputView = pickerView
        
        if let friend = friendToEdit {
            navigationItem.title = "Edit Friend"
            nameTextfield.text = friend.name
            occupationTextfield.text = friend.occupation
            dateOfBirthTextfield.text = friend.dateOfBirth
            descriptionTextView.text = friend.about
            imageViewOutlet.image = friend.image
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageViewOutlet.isUserInteractionEnabled = true
        imageViewOutlet.addGestureRecognizer(tapGestureRecognizer)
        
        imageViewOutlet.layer.cornerRadius = imageViewOutlet.frame.size.width/2
        imageViewOutlet.layer.masksToBounds = true
        
        descriptionTextView.delegate = self
        descriptionTextView.layer.borderColor = UIColor(red: 204/256, green: 204/256, blue: 204/256, alpha: 0.5).cgColor
        descriptionTextView.layer.borderWidth = 1
        resize(descriptionTextView)
        
        nameTextfield.delegate = self
        dateOfBirthTextfield.delegate = self
        occupationTextfield.delegate = self
        descriptionTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    func setValues (keyboardHeightfromFunc: CGFloat) {
        keyboardHeight = keyboardHeightfromFunc
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        self.view.frame.origin.y = 0
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardYPosition = self.view.frame.height - keyboardFrame.height
            setValues(keyboardHeightfromFunc: keyboardFrame.height)
            if let activeTextField = activeTextField {
                let textFieldYPosition = self.activeTextField!.frame.origin.y
            print("viewY: \(view.frame.origin.y), keyboardHeight: \(keyboardFrame.height), keyboardYPos: \(keyboardYPosition), textfieldYPos: \(textFieldYPosition)")
            
            if self.view.frame.origin.y >= 0 {
                if textFieldYPosition > keyboardYPosition {
                    print("Overlaps")
                    self.view.frame.origin.y -= (textFieldYPosition - keyboardYPosition + 35)
                } else {
                    print("Doesnt Overlap")
                }
            }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }

    }
    
    
    func resize (_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 40, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
//    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
//        if let friend = friendToEdit {
//            let storyboardID = UIStoryboard(name: "Main", bundle: nil)
//            if let thirdVC = storyboardID.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
//                thirdVC.friend = friend
//        //           thirdVC.delegate = self
//                navigationController?.pushViewController(thirdVC, animated: true)
//            }
//        }
//    }

    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateOfBirthTextfield.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        
        if let friend = friendToEdit {
            if let name = nameTextfield.text, let occupation = occupationTextfield.text, let dateOfBirth = dateOfBirthTextfield.text {
                friend.name = name
                friend.image = imageViewOutlet.image
                friend.occupation = occupation
                friend.dateOfBirth = dateOfBirth
                friend.about = descriptionTextView.text
                delegate?.addFriendViewController(self, didFinishEditing: friend)
            }
        } else {
            let friend = Friend(name: String(), image: UIImage(), dateOfBirth: String(), occupation: String(), about: String())
            if let name = nameTextfield.text, let occupation = occupationTextfield.text, let description = descriptionTextView.text, let image = imageViewOutlet.image, let dateOfBirth = dateOfBirthTextfield.text {
                
                if name.isEmpty {
                    nameAlertLabel.textColor = UIColor.red
                    nameAlertLabel.text = "Please enter a name"
                } else {
                    nameAlertLabel.text = ""
                }
                if occupation.isEmpty {
                    occupationAlertLabel.textColor = UIColor.red
                    occupationAlertLabel.text = "Please enter an occupation"
                } else {
                    occupationAlertLabel.text = ""
                }
                if dateOfBirth.isEmpty {
                    dateOfBirthAlertLabel.textColor = UIColor.red
                    dateOfBirthAlertLabel.text = "Please pick a date"
                } else {
                    dateOfBirthAlertLabel.text = ""
                }
                if description.isEmpty{
                    descriptionAlertLabel.textColor = UIColor.red
                    descriptionAlertLabel.text = "Please enter a description"
                } else {
                    descriptionAlertLabel.text = ""
                }
                if !didSelectImage {
                    imageAlertLabel.text = "Please add an image"
                    imageAlertLabel.textColor = UIColor.red
                }
                if !name.isEmpty && !occupation.isEmpty && !description.isEmpty && didSelectImage && !dateOfBirth.isEmpty {
                    friend.name = name
                    friend.image = image
                    friend.dateOfBirth = dateOfBirth
                    friend.occupation = occupation
                    friend.about = description
                    delegate?.addFriendViewController(self, didFinishAdding: friend)
                }
            }
        }
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addFriendDidCancel(self)
    }
    
}

extension AddFriendTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        occupationTextfield.text = pickOption[row]
    }
    
}

extension AddFriendTableViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Keyboard height: \(keyboardHeight)")
        let keyboardYPosition = self.view.frame.height - keyboardHeight
         let textViewYPosition = self.descriptionTextView.frame.origin.y
        if self.view.frame.origin.y >= 0 {
            if textViewYPosition > keyboardYPosition {
                print("Overlaps")
                self.view.frame.origin.y -= (textViewYPosition - keyboardYPosition + 35)
            } else {
                print("Doesnt Overlap")
            }
        }
    }
    
    func setView () {
        
        self.view.frame.origin.y = 0
        var keyboardYPosition: CGFloat = 0
        keyboardYPosition = self.view.frame.height - keyboardHeight
        let textFieldYPosition = self.activeTextField!.frame.origin.y
        print("active field \(activeTextField?.text), Keyboard height: \(keyboardHeight)")
        if self.view.frame.origin.y >= 0 {
            if textFieldYPosition > keyboardYPosition {
                print("Overlapping")
                self.view.frame.origin.y -= (textFieldYPosition - keyboardYPosition + 35)
            } else {
                print("Doesnot Overlap")
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        setView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch (textField) {
        case nameTextfield:
            nameTextfield.resignFirstResponder()
            dateOfBirthTextfield.becomeFirstResponder()
            break
        case dateOfBirthTextfield:
            dateOfBirthTextfield.resignFirstResponder()
            
            occupationTextfield.becomeFirstResponder()
            break
        case occupationTextfield:
            occupationTextfield.resignFirstResponder()
            descriptionTextView.becomeFirstResponder()
            break
        default:
            break
        }
        return false
    }
    
}

extension AddFriendTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ThirdViewControllerDelegate {
    
    func sendImageInfoToAddFriendTableView(image: UIImage) {
        imageViewOutlet.image = image
    }

    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if let friend = friendToEdit {
            let storyboardID = UIStoryboard(name: "Main", bundle: nil)
            if let thirdVC = storyboardID.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
                thirdVC.friendEdit = friend
                thirdVC.delegate = self
                navigationController?.pushViewController(thirdVC, animated: true)
            }
        } else {
            
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { (_) in
                self.openCamera()
            }
            let choosePhoto = UIAlertAction(title: "Choose Photo", style: .default) { (_) in
                self.openGallery()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

            actionSheetController.addAction(takePhoto)
            actionSheetController.addAction(choosePhoto)
            actionSheetController.addAction(cancelAction)

            present(actionSheetController, animated: true, completion: nil)
        }
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
        if let image = info[.originalImage] as? UIImage {
            didSelectImage = true
            imageAlertLabel.text = ""
            imageViewOutlet.image = image
        }
        picker.dismiss(animated: false)
    }
}

