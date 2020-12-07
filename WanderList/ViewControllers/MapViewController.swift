//
//  MapViewController.swift
//  WanderList
//
//  Created by Neel B Gandhi on 11/27/20.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: Variables and Properties
    var place:Place?
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        if place != nil {
            
            // Create a CLLocationCoordinate2D using latitude and longitude
            let location = CLLocationCoordinate2D(latitude: place!.lat, longitude: place!.long)
            
            // Create a pin
            let pin = MKPointAnnotation()
            pin.coordinate = location
            
            // Add pin to the map
            mapView.addAnnotation(pin)
            
            // Create a region to zoom to
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: false)
        }
    }
}
