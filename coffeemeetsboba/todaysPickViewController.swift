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

class todaysPickViewController: UIViewController {
    
    @IBOutlet weak var numOfPickLeft: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantInfoLabel: UILabel!
    @IBOutlet weak var colorCard: UIImageView!
    @IBOutlet weak var displayIcon: UIImageView!
    
    
    var business: Business?
    var numOfPick = 1
    var pickList : [Business]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tea == true{
            if let randomElement = teaList.randomElement() {
                //print(randomElement.address)
                restaurantInfoLabel.text = randomElement.name
                restaurantImg.kf.setImage(with: randomElement.imageURL)
            }
        
        } else{
            colorCard.image = UIImage(named:"yellowcard")
            displayIcon.image = UIImage(named:"tea")
            
            
            if let randomElement = coffeeList.randomElement() {
                restaurantInfoLabel.text = randomElement.name
                restaurantImg.kf.setImage(with: randomElement.imageURL)
            }
 
        }
        
    }
    
    
    @IBAction func skip(_ sender: Any) {
        if numOfPick >= 0{
            if tea == true{
                if let randomElement = teaList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                }
            } else{
                if let randomElement = coffeeList.randomElement() {
                    restaurantInfoLabel.text = randomElement.name
                    restaurantImg.kf.setImage(with: randomElement.imageURL)
                }
                
            }
            let numOfPickLeftLabel = "You have " + String(numOfPick) + " pick(s) left!"
            numOfPickLeft.text = numOfPickLeftLabel
            numOfPick-=1
        }else{
            performSegue(withIdentifier: "browseMore", sender: sender)
        }
        
    }
    
    
    
    
    
}
