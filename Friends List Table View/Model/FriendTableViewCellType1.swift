//
//  FriendTableViewCell.swift
//  Friends List Table View
//
//  Created by yash on 05/08/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

class FriendTableViewCellType1: UITableViewCell {
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendAboutLabel: UILabel!
    
    func setFriend(friend: Friend) {
        friendImageView.image = friend.image
        friendNameLabel.text = friend.name
        friendAboutLabel.text = friend.about
        
        friendImageView.layer.cornerRadius = friendImageView.frame.size.width/2
        friendImageView.layer.masksToBounds = true
    }
    
}
