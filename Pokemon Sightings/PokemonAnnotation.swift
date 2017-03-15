//
//  PokemonAnnotationView.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/13/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotation : MKPointAnnotation {
    
    var pokemon :Pokemon!
    
    init(pokemon :Pokemon) {
        
        super.init()
        
        self.title = pokemon.name
        self.coordinate = CLLocationCoordinate2D(latitude: pokemon.latitude, longitude: pokemon.longitude)
        self.pokemon = pokemon
    }
}
