//
//  restaurantDisplayViewController.swift
//  coffeemeetsboba
//
//  Created by aliceyang on 4/3/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import UIKit

class restaurantDisplayViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var restaurantCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCollectionViewCell", for: indexPath) as? restaurantCollectionViewCell{
            //cell.image.image = UIImage(named: teaList[indexPath.item].imageURL)
            if tea == true{
                cell.image.kf.setImage(with: teaList[indexPath.item].imageURL)
                cell.label.text = teaList[indexPath.item].name
                return cell
            }else{
                cell.image.kf.setImage(with: coffeeList[indexPath.item].imageURL)
                cell.label.text = coffeeList[indexPath.item].name
                return cell
            }
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let dimension = self.restaurantCollectionView.frame.size.width / 2 - 5
        return CGSize(width:dimension, height:dimension)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tea)
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
}

class  restaurantCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
}
