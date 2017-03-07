//
//  Pokemon.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/7/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import Foundation

class Pokemon {
    var id :Int!
    var imageURL :String!
    var latitude :Double!
    var longitude :Double!
    var name :String!
    
    init(dictionary :[String:Any]) {
        
        self.id = dictionary ["id"] as! Int
        self.imageURL = dictionary["imageURL"] as! String
        self.latitude = dictionary["latitude"] as! Double
        self.longitude = dictionary["longitude"] as! Double
        self.name = dictionary["name"] as! String
        
    }
}
