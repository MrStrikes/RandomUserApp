//
//  ViewController.swift
//  Random User App
//
//  Created by Yanis Bendahmane on 09/01/2019.
//  Copyright © 2019 Yanis Bendahmane. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class ViewController: UIViewController {
    // In fact, with the initials RUA, it means Random User App
    @IBOutlet weak var totallyStolenLogo: UIImageView!
    
    override func viewDidLoad() {
        let url = URL(string: "https://www.revistarua.pt/wp-content/uploads/2018/04/ruaPreto.png")
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!);
        totallyStolenLogo.image = image
        self.view.backgroundColor = UIColor(hexString: "#757575")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getData(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "firstname") == nil {
            ApiManager().getRandomUserHydratedWithPerson(completion: {person in
                UserDefaults.standard.set(person.firstname, forKey: "firstname")
                UserDefaults.standard.set(person.lastname, forKey: "lastname")
                UserDefaults.standard.set(person.gender.rawValue, forKey: "gender")
                UserDefaults.standard.set(person.birthdate.toString(format: "dd-mm-YYYY"), forKey: "birthdate")
                UserDefaults.standard.set(person.picture, forKey: "image")
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "GetData", sender: person)
                }
            })
        } else {
            let firstname = UserDefaults.standard.string(forKey: "firstname")
            let lastname = UserDefaults.standard.string(forKey: "lastname")
            let gender = UserDefaults.standard.string(forKey: "gender")
            let picture = UserDefaults.standard.string(forKey: "image")
            let birthdate = UserDefaults.standard.string(forKey: "birthdate")
            
            let data = Person(firstname: firstname!, lastname: lastname!, gender: Gender(rawValue: gender!)!, email: "none@yanisbendahmane.fr", picture: picture!, birthdate: (date: birthdate!, format: "dd-mm-YYYY"))
            self.performSegue(withIdentifier: "GetData", sender: data)
        }

    }
    
    @IBAction func clearCache(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "firstname")
        UserDefaults.standard.removeObject(forKey: "lastname")
        UserDefaults.standard.removeObject(forKey: "gender")
        UserDefaults.standard.removeObject(forKey: "birthdate")
        UserDefaults.standard.removeObject(forKey: "image")

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GetData" {
            let viewController = segue.destination as! ViewController2
            viewController.person = (sender as! Person)
        }
    }
}
