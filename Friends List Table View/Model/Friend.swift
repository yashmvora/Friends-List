//
//  Friend.swift
//  Friends List Table View
//
//  Created by yash on 24/07/19.
//  Copyright © 2019 yash. All rights reserved.
//

import Foundation
import UIKit

class Friend: NSObject {
    
    var name: String = ""
    var image: UIImage?
    var dateOfBirth: String?
    var occupation: String = ""
    var about: String = ""
    
    init(name: String, image: UIImage, dateOfBirth: String, occupation: String, about: String) {
        self.name = name
        self.image = image
        self.dateOfBirth = dateOfBirth
        self.occupation = occupation
        self.about = about
    }
 
    func addFriend() -> Friend {
        let newFriend = Friend(name: "Sid Jain", image: UIImage(named: "Sid")!, dateOfBirth: "01/09/1999", occupation: "Investor", about: "Very hardworking. Always late for everything.")
        return newFriend
    }
    
}
