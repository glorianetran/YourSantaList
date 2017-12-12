//
//  FriendInfoViewController.swift
//  YourSantaList
//
//  Created by Gloriane Tran on 12/11/17.
//  Copyright © 2017 Gloriane Tran. All rights reserved.
//

import UIKit

protocol FriendDetailSaver{
    func saveFavorite(friendInfo: Person)
}

class FriendInfoViewController: UIViewController {

    var delegate:FriendDetailSaver!
    
    @IBOutlet weak var statusL: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var evidenceTF: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var evidenceLabel: UILabel!
    @IBOutlet weak var nightSwitch: UISwitch!
    
    
    var name:String!
    var status:Bool!
    var evidence:String!
    var userDefaults = UserDefaults.standard
    var nightIsOn:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = name
        
        // Night Mode
        let nightIsOn = userDefaults.bool(forKey: "nightIsOn")
        nightSwitch.isOn = nightIsOn
        
        switch nightIsOn{
        case true:
            setImageLight()
            setNightMode()
        case false:
            setImageDark()
            setDayMode()
        }
        evidenceTF.text = evidence
    }
    
    
    @IBAction func toggleButton(_ sender: UISwitch){
        let nightIsOn = sender.isOn

        switch nightIsOn{
        case true:
           setNightMode()
           setImageLight()
        case false:
           setDayMode()
           setImageDark()
        }
        
        //save preference
        userDefaults.set(nightIsOn, forKey: "nightIsOn")
    }
    
    func setDayMode(){
        label.textColor = UIColor.black
        evidenceLabel.textColor = UIColor.black
        view.backgroundColor = UIColor.white
    }
    
    func setNightMode(){
        label.textColor = UIColor.white
        evidenceLabel.textColor = UIColor.white
        view.backgroundColor = UIColor.black
    }
    
    func setImageLight(){
        if(status){
            statusL.text = "Nice"
            imageView.image = UIImage(named: "lightCandyCane")
        }else{
            statusL.text = "Naughty"
            imageView.image = UIImage(named:"lightCoal")
        }
    }
    
    func setImageDark(){
        if(status){
            statusL.text = "Nice"
            imageView.image = UIImage(named: "candycane")
        }else{
            statusL.text = "Naughty"
            imageView.image = UIImage(named:"coal")
        }
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let editViewController = segue.destination as! EditViewController
        editViewController.delegate = delegate
        editViewController.text = evidenceTF.text
        editViewController.status = status
        editViewController.name = name
    }
    
}
