//
//  PokemonARViewController.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/14/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import MapKit
import HDAugmentedReality

class PokemonARViewController: ARViewController, ARDataSource, CLLocationManagerDelegate {
    
    var pokemons = [Pokemon]()
    var pokemonARAnnotations = [ARAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        self.headingSmoothingFactor = 0.05
        self.maxVisibleAnnotations = 30

        self.getPokemon()
    }
    
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        
        let annotationView = ARAnnotationView()
        annotationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        annotationView.backgroundColor = UIColor.red
        return annotationView
        
    }

    private func getPokemon() {
        
        let url = URL(string: "https://still-wave-26435.herokuapp.com/pokemon/all")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            
            //using map function
            self.pokemons = json.map(Pokemon.init)
            
            for pokemon in self.pokemons {
                
                let arAnnotation = ARAnnotation()
                arAnnotation.title = pokemon.name
                arAnnotation.location = CLLocation(latitude: pokemon.latitude, longitude: pokemon.longitude)
                
                //add ar annotation to array
                self.pokemonARAnnotations.append(arAnnotation)
            }
            
            self.setAnnotations(self.pokemonARAnnotations)

            }.resume()
    }
    



}
