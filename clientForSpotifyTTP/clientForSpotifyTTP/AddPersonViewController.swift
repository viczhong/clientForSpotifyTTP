//
//  AddPersonViewController.swift
//  clientForSpotifyTTP
//
//  Created by Victor Zhong on 3/19/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets and Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        postEntry()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.isEnabled = false
        self.nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // MARK: - Functions and Methods
    
    func textFieldDidChange(_ textField: UITextField) {
        addButton.isEnabled = true
    }
    
    func postEntry() {
        if let name = nameTextField.text, let email = emailTextField.text, let city = cityTextField.text {
            
            let data: [String : Any] = [
                "name" : name,
                "email" : email,
                "favoriteCity" : city
            ]
            
            APIRequestManager.manager.postRequest(endPoint: "https://serverforspotify.herokuapp.com/people/", data: data)
            
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
