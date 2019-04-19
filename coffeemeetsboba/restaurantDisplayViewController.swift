//
//  restaurantDisplayViewController.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 4/3/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import UIKit

class restaurantDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var restaurantTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tea == true{
            return teaList.count
        }
        else{
            return coffeeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tea == true{
            if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell") as? restaurantTableViewCell{
                print("tea")
                cell.restaurantAddress.text = teaList[indexPath.row].address
                cell.numOfReview.text = teaList[indexPath.row].reviewCount?.stringValue
                //cell.restaurantImg.kf.setImage(with: teaList[indexPath.row].imageURL)
                cell.restaurantName.text = teaList[indexPath.row].name
                return cell
            }
            return UITableViewCell()
        }
        else{
            if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell") as? restaurantTableViewCell{
                print("coffee")
                cell.restaurantAddress.text = coffeeList[indexPath.row].address
                cell.numOfReview.text = coffeeList[indexPath.row].reviewCount?.stringValue
                //cell.restaurantImg.kf.setImage(with: coffeeList[indexPath.row].imageURL)
                cell.restaurantName.text = coffeeList[indexPath.row].name
                return cell
            }
            return UITableViewCell()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tea)
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
}

class  restaurantTableViewCell : UITableViewCell {
    
    @IBOutlet weak var numOfReview: UILabel!
    @IBOutlet weak var restaurantAddress: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantImg: UIImageView!
}
