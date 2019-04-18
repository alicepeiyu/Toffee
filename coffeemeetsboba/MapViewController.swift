//
//  MapViewController.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/4.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let store = MKPointAnnotation()
        store.title = "Moffitt Library"
        let coordinate = CLLocationCoordinate2D(latitude: 37.872574, longitude: -122.260748)
        
        store.coordinate = coordinate
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500), animated: true)
        mapView.addAnnotation(store)
        
    }
    
}
