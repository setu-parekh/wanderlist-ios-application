//
//  ViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/27/20.
//

import UIKit

class ViewController: UIViewController {
    
    // Get a reference to core data context
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get all the places from core data
        do {
            places = try context.fetch(Place.fetchRequest())
        }
        catch {
            print("Failed to fetch places from database.")
        }
        
        // Set view controller as the delegate and datasource of table view
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Double check that a row was selected
        if tableView.indexPathForSelectedRow == nil {
            // User did not select any row
            return
        }
        else {
            // Get the selected place
            let selectedPlace = self.places[tableView.indexPathForSelectedRow!.row]
            
            // Get reference to the PlaceViewController and set place property
            let placeViewController = segue.destination as! PlaceViewController
            placeViewController.place = selectedPlace
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell reference
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.PLACE_CELL) as! PlaceTableViewCell
        
        // Get the place
        let place = self.places[indexPath.row]
        
        // Customize the cell for the place we are trying to show
        cell.setCell(place)
        
        // Return the cell
        return cell
    }
}
