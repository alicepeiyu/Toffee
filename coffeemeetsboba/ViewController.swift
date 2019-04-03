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

var teaList: [Business]!
var coffeeList: [Business]!
var tea = true

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Business.searchWithTerm(term: "tea", sort: .distance, categories: ["tea","bubbletea"]) { (businesses, error) in
            teaList = businesses
            for business in teaList {
                print(business.name!)
                print(business.address!)
                //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
            }
        }
        
        Business.searchWithTerm(term: "coffee", sort: .distance, categories: ["coffee","coffeeroasteries","coffeeshops"]) { (businesses, error) in
            coffeeList = businesses
            for business in coffeeList {
                print(business.name!)
                print(business.address!)
                //self.slices = [ CarnivalWheelSlice.init(title: business.name!)]
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

    }
    

}

extension UIViewController{
    @objc func swipeAction(swipe:UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "swipeRight", sender: self)
        case 2:
           tea = false
           performSegue(withIdentifier: "swipeRight", sender: self)
        default:
            break
        }
        
    }
}

