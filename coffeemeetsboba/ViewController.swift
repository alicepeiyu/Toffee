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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var isTea: Bool!
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        if(locationManager.location?.coordinate.latitude != nil){
//            Business.searchWithTerm(term: "tea", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!,sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
//                teaList = businesses
//                for business in teaList {
//                    print("TEA")
//                    print(business.name!)
//                    print(business.address!)
//                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
//                }
//            }
//
//            Business.searchWithTerm(term: "coffee", lat: (locationManager.location?.coordinate.latitude)!, long: (locationManager.location?.coordinate.longitude)!, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
//                coffeeList = businesses
//                for business in coffeeList {
//                    print("COFFEE")
//                    print(business.name!)
//                    print(business.address!)
//                    //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
//                }
//            }
//        }

    }
    
    @IBAction func pickCoffee(_ sender: Any) {
        isTea = false
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
    @IBAction func pickTea(_ sender: Any) {
        isTea = true
        performSegue(withIdentifier: "swipeRight", sender: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        print("update")
        lat = locValue.latitude
        long = locValue.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("error")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? todaysPickViewController{
                dest.isTea = self.isTea
                dest.lat = self.lat
                dest.long = self.long
            }
        }
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

