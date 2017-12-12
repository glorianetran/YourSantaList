//
//  FriendsTableViewController.swift
//  YourSantaList
//
//  Created by Gloriane Tran on 12/11/17.
//  Copyright © 2017 Gloriane Tran. All rights reserved.
//

import UIKit


class FriendsTableViewController: UITableViewController, FriendDetailSaver {
    
    var friends:[Person] = []
    var tField: UITextField!
    var index: Int!

    @IBAction func addFriend(_ sender: Any) {
 
        func configurationTextField(textField: UITextField!){
            textField.placeholder = "Enter name here"
            tField = textField
        }
        
        let alert = UIAlertController(title: "Add Friend", message: "Enter a friend's name.", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: configurationTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler:{ (UIAlertAction) in
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                let friendName = alertTextField.text!
                
                //make new Friend, put into array
                let newFriend = Person(name: friendName, status: false, evidence: "Didn't say hi to me.")
                
                self.friends.append(newFriend)
                self.tableView.reloadData()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "present"))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendIdentifier", for: indexPath)
        cell.textLabel?.text = friends[indexPath.row].name
        
        if(friends[indexPath.row].status){
            cell.imageView?.image = UIImage(named: "candyCaneIcon")
        }else{
            cell.imageView?.image = UIImage(named: "coalIcon")
        }
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            friends.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let friendInfoController = segue.destination as! FriendInfoViewController
        let selectedRow = tableView.indexPathForSelectedRow!.row
        
        // pass information
        friendInfoController.name = friends[selectedRow].name
        friendInfoController.status = friends[selectedRow].status
        friendInfoController.evidence = friends[selectedRow].evidence
        
        //save cell you are working with
        index = selectedRow
        
        //set the delegate for editing
        friendInfoController.delegate = self
    }
    
    func saveFavorite(friendInfo: Person) {
        // alters data for selected cell when editing
        friends[index].status = friendInfo.status
        friends[index].evidence = friendInfo.evidence
        
        tableView.reloadData()
    }
 

}
