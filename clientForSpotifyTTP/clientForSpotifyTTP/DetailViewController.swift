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
        
        let textFields = [nameTextField, cityTextField]
        
        _ = textFields.map {
            $0?.delegate = self
        }
        _ = textFields.map {
            $0?.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    // MARK: - Functions and Methods
    
    func textFieldDidChange(_ textField: UITextField) {
        // If user edits a field, allow for Update
        updateButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // If Name field is first responder, return key should move cursor to city field
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            cityTextField.becomeFirstResponder()
            return true
        }
        else {
            // If City field is first responder, return key should dismiss keyboard so user can observe changes
            self.view.endEditing(true)
            return false
        }
    }
    
    func loadPersonIntoTextFields() {
        if let person = person {
            nameTextField.text = person.name
            cityTextField.text = person.favoriteCity
        }
    }
    
    func putEntry() {
        if let person = person,
            let name = nameTextField.text,
            let city = cityTextField.text {
            let editedPerson = Person(id: person.id, name: name, favoriteCity: city)
            
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
