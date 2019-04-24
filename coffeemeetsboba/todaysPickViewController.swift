//
//  todaysPickViewController.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 4/3/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import CoreLocation


class todaysPickViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var numOfPickLeft: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantInfoLabel: UILabel!
    @IBOutlet weak var colorCard: UIImageView!
    @IBOutlet weak var displayIcon: UIImageView!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    
    var selectedBusiness: Business?
    var numOfPick = 1
    
    var teaList: [Business]!
    var coffeeList: [Business]!
    var isTea: Bool!
    
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Create the Activity Indicator
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        
        // Add it to the view where you want it to appear
        view.addSubview(activityIndicator)
        
        // Set up its size (the super view bounds usually)
        activityIndicator.frame = view.bounds
        
        // Start the loading animation
        activityIndicator.startAnimating()
        
        // To remove it, just call removeFromSuperview()
        //activityIndicator.removeFromSuperview()
        
        if isTea{
            Business.searchWithTerm(term: "tea", lat: lat, long: long,sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
                self.teaList = businesses
                activityIndicator.removeFromSuperview()
                if let randomElement = self.teaList.randomElement() {
                    //print(randomElement.address)
                    self.restaurantInfoLabel.text = randomElement.name
                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.selectedBusiness = randomElement
                }
            }
        }else{
            self.colorCard.image = UIImage(named:"yellowcard")
            self.displayIcon.image = UIImage(named:"tea")
            Business.searchWithTerm(term: "coffee", lat: lat, long: long, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
                self.coffeeList = businesses
                activityIndicator.removeFromSuperview()
                if let randomElement = self.coffeeList.randomElement() {
                    self.restaurantInfoLabel.text = randomElement.name
                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.selectedBusiness = randomElement
                }
            }
        }

        
//        if isTea == true{
//            if let randomElement = self.teaList.randomElement() {
//                //print(randomElement.address)
//                restaurantInfoLabel.text = randomElement.name
//                restaurantImg.kf.setImage(with: randomElement.imageURL)
//                restaurantDistanceLabel.text = randomElement.distance! + " away"
//                selectedBusiness = randomElement
//            }
//
//        } else{
//            colorCard.image = UIImage(named:"yellowcard")
//            displayIcon.image = UIImage(named:"tea")
//            if let randomElement = self.coffeeList.randomElement() {
//                restaurantInfoLabel.text = randomElement.name
//                restaurantImg.kf.setImage(with: randomElement.imageURL)
//                restaurantDistanceLabel.text = randomElement.distance! + " away"
//                selectedBusiness = randomElement
//            }
//
//        }
        
    }
    
    
    @IBAction func skip(_ sender: Any) {
        if numOfPick >= 0{
            if isTea == true{
                if let randomElement = self.teaList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                    restaurantDistanceLabel.text = randomElement.distance! + " away"
                    selectedBusiness = randomElement
                }
            } else{
                if let randomElement = self.coffeeList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                    restaurantDistanceLabel.text = randomElement.distance! + " away"
                    selectedBusiness = randomElement
                }
                
            }
            let numOfPickLeftLabel = "You have " + String(numOfPick) + " pick(s) left!"
            numOfPickLeft.text = numOfPickLeftLabel
            numOfPick-=1
        }else{
            performSegue(withIdentifier: "browseMore", sender: sender)
        }
        
    }
    
    
    @IBAction func goToPick(_ sender: Any) {
        performSegue(withIdentifier: "goToPick", sender: sender)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? MapViewController{
                dest.isTea = self.isTea
                dest.selectedBusiness = self.selectedBusiness
            }
            
            if let dest2 = segue.destination as? restaurantDisplayViewController{
                dest2.isTea = self.isTea
                dest2.coffeeList = self.coffeeList
                dest2.teaList = self.teaList
            }
        }
    }
    

    
    
}
