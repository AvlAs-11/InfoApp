//
//  JSONModel.swift
//  InfoApp
//
//  Created by Pavel Avlasov on 11.01.2022.
//

import Foundation
import UIKit

final class JSONCaller {
    
    static public let jsonInfoFile = "generated"
    
    static public func loadJson() -> [Article] {
       
        let url = Bundle.main.url(forResource: JSONCaller.jsonInfoFile, withExtension: "json")
        guard let url = url else { return [] }
            let data = try? Data(contentsOf: url)
        guard let data = data else { return [] }
            let article = try? JSONDecoder().decode([Article].self, from: data)
        guard let article = article else { return [] }
       return article
    }
}

struct Article: Codable {
    let _id : String
    let index: Int
    let guid: String
    let isActive: Bool
    let balance: String
    let picture: String
    let age: Int
    let eyeColor: String
    let name: String
    let gender: String
    let company: String
    let email: String
    let phone: String
    let address: String
    let about: String
    let registered: String
    let latitude: Double
    let longitude: Double
    let tags: [String]
    let friends: [Friend]
    let greeting: String
    let favoriteFruit: String
}

struct Friend: Codable {
    let id: Int
    let name: String
}
