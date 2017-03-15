//
//  PokemonAnnotationView.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/14/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import MapKit

class PokemonAnnotationView : MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        let pokemonAnnotation = annotation as! PokemonAnnotation
        
        let url = URL(string: pokemonAnnotation.pokemon.imageURL)!

        DispatchQueue.global().async {
            
            let imageData = try! Data(contentsOf: url)
            let pokemonImage = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                
                let pokemonImageView = UIImageView(image: pokemonImage)
                pokemonImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                
                self.addSubview(pokemonImageView)
            }
        }
        
        self.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
