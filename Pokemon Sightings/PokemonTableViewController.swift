//
//  PokemonTableViewController.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/7/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController, AddPokemonDelegate{
    
    var pokemons = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getPokemon()
        
        self.title = "Pokemon!"
                
    }
    
    private func getPokemon() {
        
        let url = URL(string: "https://still-wave-26435.herokuapp.com/pokemon/all")!
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! [[String:Any]]
            for dictionary in json {
                let pokemon = Pokemon(dictionary: dictionary)
                self.pokemons.append(pokemon)
                
            }
            
            //manually setting bad image urls to good image urls
            let foo = self.pokemons[11]
            foo.imageURL = "http://vignette2.wikia.nocookie.net/illogicopedia/images/6/61/Crystal_128_error.png"

            let fooTwo = self.pokemons[14]
            fooTwo.imageURL = "http://vignette2.wikia.nocookie.net/illogicopedia/images/6/61/Crystal_128_error.png"
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    func addPokemonDidSave(name :String, imageURL :String, latitude :Double, longitude :Double) {
        let url = URL(string: "https://still-wave-26435.herokuapp.com/pokemon/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let postBody :[String:Any] = ["name":name,"imageURL":imageURL,"latitude":latitude,"longitude":longitude]
        
        let postData = try! JSONSerialization.data(withJSONObject: postBody, options: [])
        
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            
        }.resume()
        
        self.tableView.reloadData()

    
    }
    

    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addPokemonVC :AddPokemonViewController = segue.destination as! AddPokemonViewController
        addPokemonVC.delegate = self
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell


        let pokemon = self.pokemons[indexPath.row]
        
        cell.pokemonNameLabel?.text = pokemon.name
        cell.latLabel?.text = String(pokemon.latitude)
        cell.lngLabel?.text = String(pokemon.longitude)
        
        

        DispatchQueue.global().async {
            
                let imageData = NSData(contentsOf: URL(string: pokemon.imageURL)!)
                let imagePhoto = UIImage(data: imageData as! Data)
                
                DispatchQueue.main.async {
                    cell.pokemonImageView?.image = imagePhoto
            }
            
        }
        return cell
    }
    

    
}
