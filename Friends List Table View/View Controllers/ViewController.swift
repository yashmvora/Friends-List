//
//  ViewController.swift
//  Friends List Table View
//
//  Created by yash on 19/07/19.
//  Copyright © 2019 yash. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var friends: [Friend] = []
    var friend = Friend(name: String(), image: UIImage(), dateOfBirth: String(), occupation: String(), about: String())
    
    let friendsListIdentifier1 = "FriendTableViewCellType1"
    let friendsListIdentifier2 = "FriendTableViewCellType2"
    let friendsListIdentifier3 = "FriendTableViewCellType3"
    
    @IBOutlet weak var friendsListOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsListOutlet.dataSource = self
        friendsListOutlet.delegate = self
        
        let friend0 = Friend(name: "Ayush Fomra", image: UIImage(named: "Ayush")!, dateOfBirth: "30/08/1999", occupation: "Finance", about: "Bestie. Friends from LKG. Snooker Champ.")
        let friend1 = Friend(name: "Jay Mehta", image: UIImage(named: "Jay Mehta")!, dateOfBirth: "02/03/1997", occupation: "Annoying", about: "Coder, Programmer, Developer, Teacher and Irritating. Loves Gulab Jamun and Jalebi.")
        let friend2 = Friend(name: "Srishti Sami", image: UIImage(named: "Srishti Sami")!, dateOfBirth: "17/11/1999", occupation: "Dentist", about: "BestFriend from HongKong. Biggest Fan of Lush Products. Her laughter makes others laugh for sure.")
        let friend3 = Friend(name: "Parth Shah", image: UIImage(named: "Parth")!, dateOfBirth: "05/06/1999", occupation: "Business Architecture", about: "Very smart, very hardworking and utmost dedication to his work life.")
        let friend4 = Friend(name: "Jay's Friend", image: UIImage(named: "Jay's Friend")!, dateOfBirth: "00/00/0000", occupation: "Fake Friend", about: "I don't know why he exists.")
        let friend5 = Friend(name: "Nisha Shah", image: UIImage(named: "Nisha")!, dateOfBirth: "01/01/1999", occupation: "Physiotherapist", about: "Bestfriend, Big nose and Biggest Dramebaaz")
        let friend6 = Friend(name: "Pranav", image: UIImage(named: "Pranav")!, dateOfBirth: "08/12/2001", occupation: "Gamer", about: "My brother. One of my lifelines. Smartest person I have ever met.")
        let friend7 = Friend(name: "Shrivatsa Agarwal", image: UIImage(named: "Shrivatsa")!, dateOfBirth: "06/08/1999", occupation: "Web Developer", about: "The entertainer of CityU and a young chef who cooks food for everyone.")
        let friend8 = Friend(name: "Sid Jain", image: UIImage(named: "Sid")!, dateOfBirth: "01/09/1999", occupation: "Investor", about: "Bestie. Fart Master. Very hardworking. Always late for everything.")
        
        
        friends.append(friend0)
        friends.append(friend1)
        friends.append(friend2)
        friends.append(friend3)
        friends.append(friend4)
        friends.append(friend5)
        friends.append(friend6)
        friends.append(friend7)
        friends.append(friend8)
        
        friendsListOutlet.rowHeight = UITableView.automaticDimension
        friendsListOutlet.estimatedRowHeight = friendsListOutlet.rowHeight
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        friendsListOutlet.reloadData()
    }
    
    @IBAction func addFriend(_ sender: Any) {

        let newIndexPath = friends.count
        friends.append(friend.addFriend())
        let indexPath = IndexPath(row: newIndexPath, section: 0)
        friendsListOutlet.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = friends[indexPath.row]

        switch (indexPath.row % 3) {
        case 0:
            if let cell = friendsListOutlet.dequeueReusableCell(withIdentifier: friendsListIdentifier1, for: indexPath) as? FriendTableViewCellType1 {
                cell.setFriend(friend: item)
                return cell
            }
            break
        case 1:
            if let cell = friendsListOutlet.dequeueReusableCell(withIdentifier: friendsListIdentifier2, for: indexPath) as? FriendTableViewCellType2 {
                cell.setFriend(friend: item)
                return cell
            }
            break
        case 2:
            if let cell = friendsListOutlet.dequeueReusableCell(withIdentifier: friendsListIdentifier3, for: indexPath) as? FriendTableViewCellType3 {
                cell.setFriend(friend: item)
                return cell
            }
            break
        default:
            break
        }
        print("cell for row - \(indexPath)")
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoardVC = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyBoardVC.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            secondVC.friend = friends[indexPath.row]
            navigationController?.pushViewController(secondVC, animated: true)
        }
        friendsListOutlet.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        friends.remove(at: indexPath.row)
//        friendsListOutlet.deleteRows(at: [indexPath], with: .automatic)
//    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            self.editAction(indexPath: indexPath)
        })
        
        editAction.backgroundColor = UIColor.gray
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            let startIndex = indexPath.row
            var indexPaths = [IndexPath]()
            for i in startIndex..<self.friends.count - 1 {
                indexPaths.append(IndexPath(row: i, section: 0))
            }
            
            self.friends.remove(at: indexPath.row)
            self.friendsListOutlet.deleteRows(at: [indexPath], with: .automatic)
            self.friendsListOutlet.reloadRows(at: indexPaths, with: .automatic)
        })
        
        return [deleteAction, editAction]
    }
    
    func editAction(indexPath: IndexPath) {
        let storyBoardVC = UIStoryboard(name: "Main", bundle: nil)
        if let editVC = storyBoardVC.instantiateViewController(withIdentifier: "AddFriendTableViewController") as? AddFriendTableViewController {
            editVC.friendToEdit = friends[indexPath.row]
            editVC.delegate = self
            navigationController?.pushViewController(editVC, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFriendSegue" {
            if let addFriend = segue.destination as? AddFriendTableViewController {
                addFriend.delegate = self
            }
        }
    }
    
}

extension ViewController: AddFriendViewControllerDelegate {
    
    func addFriendDidCancel(_ controller: AddFriendTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addFriendViewController(_ controller: AddFriendTableViewController, didFinishAdding friend: Friend) {
        navigationController?.popViewController(animated: true)
        let rowIndex = friends.count
        friends.append(friend)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        friendsListOutlet.insertRows(at: indexPaths, with: .automatic)
        friendsListOutlet.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.none, animated: true)
    }
    
    func addFriendViewController(_ controller: AddFriendTableViewController, didFinishEditing friend: Friend) {
        if let index = friends.index(of: friend) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = friendsListOutlet.cellForRow(at: indexPath) as? FriendTableViewCellType1 {
                cell.setFriend(friend: friend)
            } else if let cell = friendsListOutlet.cellForRow(at: indexPath) as? FriendTableViewCellType2 {
                cell.setFriend(friend: friend)
            } else if let cell = friendsListOutlet.cellForRow(at: indexPath) as? FriendTableViewCellType3 {
                cell.setFriend(friend: friend)
            }
            friendsListOutlet.reloadRows(at: [indexPath], with: .automatic)
        }
        navigationController?.popViewController(animated: true)
    }
}
