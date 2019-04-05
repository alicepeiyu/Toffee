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
    
    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var restaurantInfoLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var browseMoreButton: UIButton!
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if tea == true{
            if let randomElement = teaList.randomElement() {
                //print(randomElement.address)
                restaurantInfoLabel.text = randomElement.name
                restaurantImg.kf.setImage(with: randomElement.imageURL)
            }
        
        } else{
            //restaurantImg.kf.setImage(with: teaList[1].imageURL)
            if let randomElement = coffeeList.randomElement() {
                restaurantInfoLabel.text = randomElement.name
            }
            
            
            
        }
        
    }

    
    
    
}
