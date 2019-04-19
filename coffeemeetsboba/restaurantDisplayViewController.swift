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
    var selectedBusiness: Business?
    
    
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
                cell.restaurantImg.kf.setImage(with: teaList[indexPath.row].imageURL)
                cell.restaurantName.text = teaList[indexPath.row].name
                cell.ratingImg.image = teaList[indexPath.row].ratingImage
                return cell
            }
            return UITableViewCell()
        }
        else{
            if let cell = restaurantTableView.dequeueReusableCell(withIdentifier: "restaurantTableViewCell") as? restaurantTableViewCell{
                print("coffee")
                cell.restaurantAddress.text = coffeeList[indexPath.row].address
                cell.numOfReview.text = coffeeList[indexPath.row].reviewCount?.stringValue
                cell.restaurantImg.kf.setImage(with: coffeeList[indexPath.row].imageURL)
                cell.restaurantName.text = coffeeList[indexPath.row].name
                cell.ratingImg.image = coffeeList[indexPath.row].ratingImage
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tea == true{
            selectedBusiness = teaList[indexPath.row]
        }else{
            selectedBusiness = coffeeList[indexPath.row]
        }
        performSegue(withIdentifier: "goToMapView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? MapViewController{
                dest.isTea = tea
                dest.selectedBusiness = self.selectedBusiness
            }
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
    @IBOutlet weak var ratingImg: UIImageView!
}
