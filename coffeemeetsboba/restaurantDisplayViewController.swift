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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let dimension = self.imagePickerCollctionView.frame.size.width / 2 - 5
        return CGSize(width:dimension, height:dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageName = globalData.images[indexPath.row]
        performSegue(withIdentifier: "goToFeed", sender: collectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? FeedPickerViewController{
                dest.imageName = imageName
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerCollctionView.delegate = self
        imagePickerCollctionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
}


