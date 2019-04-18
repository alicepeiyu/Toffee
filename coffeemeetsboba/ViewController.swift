//
//  ViewController.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 3/21/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import UIKit
import TTFortuneWheel
import CDYelpFusionKit
import MapKit
import CoreLocation

var teaList: [Business]!
var coffeeList: [Business]!
var tea = true

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        //For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("yes!")
            locationManager.delegate = self
            //locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.requestLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            //print(locationManager.location?.coordinate.latitude)
        }
        
        print(locationManager.location?.coordinate.latitude)
        
        // Do any additional setup after loading the view, typically from a nib.
//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.view.addGestureRecognizer(swipeRight)
//
//        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.view.addGestureRecognizer(swipeLeft)
        
        if(locationManager.location?.coordinate.latitude != nil){
            Business.searchWithTerm(term: "tea", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!,sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
                teaList = businesses
                for business in teaList {
                    print(business.name!)
                    print(business.address!)
                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
                }
            }
            
            Business.searchWithTerm(term: "coffee", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
                coffeeList = businesses
                for business in coffeeList {
                    print(business.name!)
                    print(business.address!)
                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
                }
            }
            
        }
        
        

    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        locationValue = locValue
//    }
    
    
    @IBAction func pickTea(_ sender: Any) {
        tea = true
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
    @IBAction func pickCoffee(_ sender: Any) {
        tea = false
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier != nil{
//            if let dest = segue.destination as? todaysPickViewController{
//                if tea == true{
//
//                }else{
//                    tea = false
//                    print()
//                }
//            }
//        }
//    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print("update")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error")
    }
    
}

//extension UIViewController{
//    @objc func swipeAction(swipe:UISwipeGestureRecognizer){
//        switch swipe.direction.rawValue {
//        case 1:
//            performSegue(withIdentifier: "swipeRight", sender: self)
//        case 2:
//           tea = false
//           performSegue(withIdentifier: "swipeRight", sender: self)
//        default:
//            break
//        }
//
//    }
//}

