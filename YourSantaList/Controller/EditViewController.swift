//
//  EditViewController.swift
//  YourSantaList
//
//  Created by Gloriane Tran on 12/11/17.
//  Copyright © 2017 Gloriane Tran. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var editEvidenceTF: UITextView!
    @IBOutlet weak var toggleButton: UISwitch!
    
    var name:String!
    var status:Bool!
    var text:String!
    var delegate:FriendDetailSaver!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleButton.setOn(status, animated: true)
        navigationItem.title = name
        editEvidenceTF.text = text
        if(status){
            nice()
        }else{
            naughty()
        }
    }

    @IBAction func toggled(_ sender: Any) {
        if(toggleButton.isOn){
            status = true;
            nice()
        }else{
            status = false;
            naughty()
        }
    }
    
    func nice(){
        statusL.text = "Nice"
        imageView.image = UIImage(named: "candycane")
    }
    
    func naughty(){
        imageView.image = UIImage(named:"coal")
        statusL.text = "Naughty"
    }
    
    @IBAction func save(_ sender: Any) {
        let newFriend = Person(name: "", status: toggleButton.isOn, evidence: editEvidenceTF.text)
        delegate.saveFavorite(friendInfo: newFriend)

        //pop two views off
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
        
    }

}
