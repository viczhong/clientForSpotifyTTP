//
//  Person.swift
//  clientForSpotifyTTP
//
//  Created by Victor Zhong on 3/19/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation

enum PersonModelParseError: Error {
    case results, parsing
}

class Person {
    let id: Int
    let name: String
    let email: String?
    let favoriteCity: String?
    
    init(id: Int,
         name: String,
         email: String?,
         favoriteCity: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.favoriteCity = favoriteCity
    }
    
    convenience init?(from dictionary: [String:AnyObject]) throws {
        guard let id = dictionary["_id"] as? Int,
            let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String?,
            let favoriteCity = dictionary["favoriteCity"] as? String? else { throw PersonModelParseError.parsing }
        
        self.init(id: id,
                  name: name,
                  email: email,
                  favoriteCity: favoriteCity)
    }
    
    static func getPeople(from data: Data) -> [Person]? {
        var peopleToReturn: [Person]? = []
        
        do {
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let response = jsonData as? [[String : AnyObject]] else {
                throw PersonModelParseError.results
            }
            
            for personDict in response {
                if let person = try Person(from: personDict) {
                    peopleToReturn?.append(person)
                }
            }
        }
       
        catch {
            print("Error encountered with \(error)")
        }
        
        return peopleToReturn
    }
}

