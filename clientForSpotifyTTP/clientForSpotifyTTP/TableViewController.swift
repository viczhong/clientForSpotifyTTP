//
//  TableViewController.swift
//  clientForSpotifyTTP
//
//  Created by Victor Zhong on 3/19/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let endpoint = "https://serverforspotify.herokuapp.com/people/"
    let reuseIdentifier = "reuseID"
    let segue = "viewSegue"
    
    var people: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPeople()
    }
    
    // MARK: - Functions and Methods
    
    func loadPeople() {
        APIRequestManager.manager.getData(endPoint: endpoint) { (data: Data?) in
            if let validData = data,
                let validPeople = Person.getPeople(from: validData) {
                self.people = validPeople
                print("We have people! \(validPeople.count)")
                
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let people = people {
            return people.count
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let person = people {
            let personAtRow = person[indexPath.row]
            cell.textLabel?.text = personAtRow.name
            cell.detailTextLabel?.text = "Favorite City: \(personAtRow.favoriteCity)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if let people = people {
                let person = people[indexPath.row]
                
                APIRequestManager.manager.deleteRequest(endPoint: endpoint, id: person.id) { (response) in
                    if response != nil {
                        self.loadPeople()
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tappedCell = sender as? UITableViewCell {
            if segue.identifier == self.segue {
                let detailView = segue.destination as! DetailViewController
                let cellIndexPath = self.tableView.indexPath(for: tappedCell)!
                if let people = people {
                    let person = people[cellIndexPath.row]
                    detailView.person = person
                }
            }
        }
    }
}
