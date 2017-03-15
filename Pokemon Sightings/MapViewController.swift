//
//  MapViewController.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/13/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var pokemons = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getPokemon()
        
    }
    
    
     func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var pokemonAnnotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "PokemonAnnotationView")
        
        if pokemonAnnotationView == nil {
            pokemonAnnotationView = PokemonAnnotationView(annotation: annotation, reuseIdentifier: "PokemonAnnotationView")
        }
        
        return pokemonAnnotationView
    }
    
    
    private func getPokemon() {
        
        let url = URL(string: "https://still-wave-26435.herokuapp.com/pokemon/all")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            
            //using map function
            self.pokemons = json.map(Pokemon.init)

            
            DispatchQueue.main.async {
                self.showPokemon()
                }
            }.resume()

    }
    
    
    func showPokemon() {
                
        for pokemon in self.pokemons {
                        
            let annotation = PokemonAnnotation(pokemon: pokemon)
        
            self.mapView.addAnnotation(annotation)
        }
    }
    

}
