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
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var typeIcon: UIImageView!
    @IBOutlet weak var restaurantDistanceLabel: UILabel!
    
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var pickView: UIView!
    
    var selectedBusiness: Business?
    var numOfPick = 1
    
    var teaList: [Business]!
    var coffeeList: [Business]!
    var isTea: Bool!
    
    var lat:CLLocationDegrees!
    var long:CLLocationDegrees!
    var promotionList = ["20% OFF FIRST VISIT!", "FREE SIZE UPGRADE!", "MOST USERS ARE HERE!", "10% OFF EVERYTHING", "USER'S FAVORITE!", "$1 OFF!", "25% OFF 1PM TO 4PM!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isTea{
            typeIcon.image = UIImage(named: "coffeeblack")
            topView.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
        }
        self.pickView.layer.applySketchShadow(color: .black, alpha: 0.5, x: 4, y: 4, blur: 20, spread: 0)
        self.restaurantImg.layer.cornerRadius = 25
        self.restaurantImg.clipsToBounds = true
        self.promotionButton.layer.cornerRadius = self.promotionButton.bounds.size.height / 2
        self.promotionButton.clipsToBounds = true
        
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
                    print(randomElement.phone)
                    self.restaurantInfoLabel.text = randomElement.name
                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    self.promotionButton.backgroundColor = UIColor(red:0.40, green:0.85, blue:0.60, alpha:1.0)
                    self.selectedBusiness = randomElement
                }
            }
        }else{
            Business.searchWithTerm(term: "coffee", lat: lat, long: long, sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
                self.coffeeList = businesses
                activityIndicator.removeFromSuperview()
                if let randomElement = self.coffeeList.randomElement() {
                    self.restaurantInfoLabel.text = randomElement.name
                    self.restaurantImg.kf.setImage(with: randomElement.imageURL)
                    self.restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    self.promotionButton.backgroundColor = UIColor(red:1.00, green:0.94, blue:0.41, alpha:1.0)
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
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
                    selectedBusiness = randomElement
                }
            } else{
                if let randomElement = self.coffeeList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                    restaurantDistanceLabel.text = randomElement.distance! + " away"
                    self.promotionButton.setTitle(self.promotionList.randomElement(), for: .normal)
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

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
