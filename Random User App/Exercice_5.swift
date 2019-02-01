//
//  ToPerson.swift
//  Random User App
//
//  Created by Yanis Bendahmane on 29/11/2018.
//  Copyright © 2018 SUP'Internet. All rights reserved.
//

import Foundation

extension ApiManager{
    func getRandomUserHydratedWithPerson(completion: @escaping (Person) -> Void) {
        getRandomUser(completion: {json in            
            // Base Dict
            let baseJSON = json as! [String: Any]
            let dict = baseJSON["results"]! as! [[String: Any]]
            let result = dict[0]
            // Type Casting
            let name = result["name"] as! [String: String]
            let dob = result["dob"] as! [String: Any]
            let date = dob["date"] as! String
            let gender = result["gender"] as! String
            let email = result["email"] as! String
            let picture = result["picture"] as! [String: String]
            let large = picture["large"]
            
            completion(Person(firstname: name["first"]!, lastname: name["last"]!, gender: Gender(rawValue: gender)!, email: email, picture: large!, birthdate: (date: date, format: "yyyy-MM-dd'T'HH:mm:ssZ")))
        })
    }
}
