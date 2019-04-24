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
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var getDirectionButton: UIButton!
    @IBOutlet weak var meetFriendsButton: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var isTea : Bool!
    var selectedBusiness : Business!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initView()
//        let store = MKPointAnnotation()
//        store.title = "Moffitt Library"
//        let coordinate = CLLocationCoordinate2D(latitude: 37.872574, longitude: -122.260748)
//
//        store.coordinate = coordinate
//        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500), animated: true)
//        mapView.addAnnotation(store)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    func initView(){
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
            meetFriendsButton.backgroundColor = topView.backgroundColor
        }
        getDirectionButton.layer.borderColor = topView.backgroundColor?.cgColor
        
        // populate yelp data to view
        self.businessNameLabel.text = selectedBusiness.name
        self.addressLabel.text = selectedBusiness.address
        self.distanceLabel.text = selectedBusiness.distance
        
        // init map view
        let store = MKPointAnnotation()
        store.title = selectedBusiness.name
        let coordinate = CLLocationCoordinate2D(latitude: selectedBusiness.lat!, longitude: selectedBusiness.long! )
//        let coordinate = CLLocationCoordinate2D(latitude: 37.872574, longitude: -122.260748) Double(selectedBusiness!.long as NSNumber)
        
        store.coordinate = coordinate
        mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500), animated: true)
        mapView.addAnnotation(store)
    }
    
}
