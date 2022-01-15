//
//  InfoModel.swift
//  InfoApp
//
//  Created by Pavel Avlasov on 11.01.2022.
//

import Foundation

class InfoModel {
    var index: Int
    var balance : String
    var age: Int
    var eyeColor: String
    var name : String
    var gender: String
    var company: String
    var email: String
    var phone: String
    var address: String
    var about: String
    var registered: String
    var latitude: Double
    var longitude: Double
    var tags: [String]
    var friends: [Friend]
    var greating: String
    var favoriteFruit: String
    
    init(index: Int, balance: String, age: Int, eyeColor: String, name: String, gender: String, company: String, email: String, phone: String, address: String, about: String, registered: String, latitude: Double, longitude: Double, tags: [String], friends: [Friend], greating: String, favoriteFruit: String) {
        self.index = index
        self.balance = balance
        self.age = age
        self.eyeColor = eyeColor
        self.name = name
        self.gender = gender
        self.company = company
        self.email = email
        self.phone = phone
        self.address = address
        self.about = about
        self.registered = registered
        self.latitude = latitude
        self.longitude = longitude
        self.tags = tags
        self.friends = friends
        self.greating = greating
        self.favoriteFruit = favoriteFruit
    }
}
