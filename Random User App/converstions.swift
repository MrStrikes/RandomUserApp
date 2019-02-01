//
//  conversions.swift
//  Random User App
//
//  Created by Yanis Bendahmane on 21/11/2018.
//  Copyright © 2018 SUP'Internet. All rights reserved.
//

import Foundation

extension String{
    func toDate(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date{
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myStringafd = formatter.string(from: self)
        return myStringafd
    }
    
    func getYearDifferenceFrom(date: Date) -> Int{
        return Calendar.current.dateComponents([.year], from: self, to: date).year!
    }
}

struct Email: CustomStringConvertible{
    var email: String?
    
    var description: String {
        return email!
    }

    init(email: String) {
        self.email = email
    }
    
    func isValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.email)
    }
}

class Existence{
    var birthdate: Date
    var age: Int
    
    init(date: Date?){
        self.birthdate = date!
        self.age = (date?.getYearDifferenceFrom(date: Date()))!
    }
    
    func willProbablyDieSoon() -> Bool{
        if age > 100 {
            return true
        }
        return false
    }
}

enum Gender: String{
    case Male = "male"
    case Female = "female"
    case Other = "other"
}

class Person: Existence{
    var gender: Gender
    var firstname: String
    var lastname: String
    var email: Email
    var picture: String
    
    init(firstname: String, lastname: String, gender: Gender, email: String, picture: String, birthdate: (date: String, format: String)){
        self.firstname = firstname
        self.lastname = lastname
        self.gender = gender
        self.email = Email(email: email)
        self.picture = picture
        super.init(date: birthdate.date.toDate(format: birthdate.format))
    }
    
    init(firstname: String, lastname: String, gender: Gender, email: String, picture: String, birthdate: Date){
        self.firstname = firstname
        self.lastname = lastname
        self.gender = gender
        self.email = Email(email: email)
        self.picture = picture
        super.init(date: birthdate)
    }
    
    func show() {
        
        print("firstname : \(self.firstname) ")
        print("lastname : \(self.lastname) ")
        
        switch self.gender {
        case .Male:
            print("gender : Male")
        case .Female:
            print("gender : Male")
        case .Other:
            print("gender : Other")
        }
        
        print("email valid : \(self.email.isValid()))")
        print("email : \(self.email))")
        
        print("birthdate : \(self.birthdate)")
        print("age : \(self.age)")
        print("will die soon : \(self.willProbablyDieSoon())")
        
    }
}
