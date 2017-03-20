//
//  DetailViewController.swift
//  clientForSpotifyTTP
//
//  Created by Victor Zhong on 3/19/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets and Properties
    
    var person: Person?
    var editedPerson: Person?
    let endpoint = "https://serverforspotify.herokuapp.com/people/"
    
    // Text Fields
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    // Buttons
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteEntry()
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        putEntry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButton.isEnabled = false
        loadPersonIntoTextFields()
        
        let textFields = [nameTextField, emailTextField, cityTextField]
        
        _ = textFields.map {
            $0?.delegate = self
        }
        _ = textFields.map {
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Functions and Methods
    
    func textFieldDidChange(_ textField: UITextField) {
        updateButton.isEnabled = true
    }
    
    func loadPersonIntoTextFields() {
        if let person = person {
            nameTextField.text = person.name
            emailTextField.text = person.email
            cityTextField.text = person.favoriteCity
        }
    }
    
    func putEntry() {
        if let person = person,
            let name = nameTextField.text,
            let email = emailTextField.text,
            let city = cityTextField.text {
            let editedPerson = Person(id: person.id, name: name, email: email, favoriteCity: city)
            
            APIRequestManager.manager.putRequest(endPoint: endpoint, id: person.id, person: editedPerson)
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    func deleteEntry() {
        if let person = person {
            APIRequestManager.manager.deleteRequest(endPoint: endpoint, id: person.id, callback: { (response) in })
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
