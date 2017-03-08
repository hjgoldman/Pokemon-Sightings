//
//  AddPokemonViewController.swift
//  Pokemon Sightings
//
//  Created by Hayden Goldman on 3/7/17.
//  Copyright © 2017 Hayden Goldman. All rights reserved.
//

import UIKit

protocol AddPokemonDelegate {
    func addPokemonDidSave(name :String, imageURL :String, latitude :Double, longitude :Double)
}

class AddPokemonViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var imageURLTextField: UITextField?
    @IBOutlet weak var latitudeTextField: UITextField?
    @IBOutlet weak var longitudeTextField: UITextField?
    var delegate: AddPokemonDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField?.delegate = self
        imageURLTextField?.delegate = self
        latitudeTextField?.delegate = self
        longitudeTextField?.delegate = self
    }
    
    @IBAction func addButtonPressed() {
        
        let name = self.nameTextField?.text
        
        if (name?.characters.count == 0) {
            let alertController = UIAlertController(title: "Whoops!", message:
                "Add a name", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let imageURL = self.imageURLTextField?.text
        
        
        if (imageURL?.characters.count)! < 10 {
            let alertController = UIAlertController(title: "Whoops!", message:
                "Not a valid URL", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
            
        }
        
        guard let latitude = Double((self.latitudeTextField?.text!)!) else {
            let alertController = UIAlertController(title: "Whoops!", message:
                "Not a valid latitude/longitude value", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let longitude = Double((self.longitudeTextField?.text!)!) else {
            let alertController = UIAlertController(title: "Whoops!", message:
                "Not a valid latitude/longitude value", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        self.delegate?.addPokemonDidSave(name: name!, imageURL: imageURL!, latitude: latitude, longitude: longitude)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
