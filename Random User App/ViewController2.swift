//
//  ViewController2.swift
//  Random User App
//
//  Created by Yanis Bendahmane on 09/01/2019.
//  Copyright © 2019 Yanis Bendahmane. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstnameInfos: UILabel!
    @IBOutlet weak var lastnameInfos: UILabel!
    @IBOutlet weak var sexInfos: UILabel!
    @IBOutlet weak var dateOfBirthInfos: UILabel!

    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    @IBAction func exitSegue(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var person: Person?
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(hexString: "#757575")
        firstnameLabel.backgroundColor = .clear
        firstnameLabel.layer.cornerRadius = 5
        firstnameLabel.layer.borderWidth = 1
        firstnameLabel.layer.borderColor = UIColor.black.cgColor
        lastnameLabel.backgroundColor = .clear
        lastnameLabel.layer.cornerRadius = 5
        lastnameLabel.layer.borderWidth = 1
        lastnameLabel.layer.borderColor = UIColor.black.cgColor
        genderLabel.backgroundColor = .clear
        genderLabel.layer.cornerRadius = 5
        genderLabel.layer.borderWidth = 1
        genderLabel.layer.borderColor = UIColor.black.cgColor
        dobLabel.backgroundColor = .clear
        dobLabel.layer.cornerRadius = 5
        dobLabel.layer.borderWidth = 1
        dobLabel.layer.borderColor = UIColor.black.cgColor
        
        let url = URL(string: self.person!.picture)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!);
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.firstnameInfos.text = self.person?.firstname
            self.lastnameInfos.text = self.person?.lastname
            self.sexInfos.text = self.person?.gender.rawValue
            self.dateOfBirthInfos.text = self.person?.birthdate.toString(format: "dd-mm-YYYY")
            self.userImage.image = image
            //userImage.image = UIImage(data: data!)
        }
    }
}
