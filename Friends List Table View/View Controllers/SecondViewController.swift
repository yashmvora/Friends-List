//
//  SecondViewController.swift
//  Friends List Table View
//
//  Created by yash on 19/07/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var friend: Friend?
    
    let backgroundImageView = UIImageView()
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textViewOutlet: UITextView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.masksToBounds = true
        
        self.navigationItem.title = friend?.name
        labelName.text = friend?.name
        dateOfBirthLabel.text = friend?.dateOfBirth
        labelDescription.text = friend?.occupation
        imageView.image = friend?.image
        textViewOutlet.text = friend?.about
        

        
        textViewOutlet.layer.borderColor = UIColor.lightGray.cgColor
        textViewOutlet.layer.borderWidth = 1
        textViewOutlet.delegate = self
        textViewOutlet.isScrollEnabled = false
        textViewDidChange(textViewOutlet)
        //setBackground()
        
    }
    
//    func setBackground() {
//
//        view.addSubview(backgroundImageView)
//
//        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        backgroundImageView.image = UIImage(named: "background")
//        view.sendSubviewToBack(backgroundImageView)
//
//    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let storyboardID = UIStoryboard(name: "Main", bundle: nil)
        if let thirdVC = storyboardID.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
            thirdVC.friend = friend
//            thirdVC.delegate = self
        navigationController?.pushViewController(thirdVC, animated: true)
        }
    }
    
}

//extension SecondViewController: ThirdViewControllerDelegate {
//
//    func sendImageInfoToSecondVC(image: UIImage) {
//        imageView.image = image
//        friend?.image = image
//    }
//}

extension SecondViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 40, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
