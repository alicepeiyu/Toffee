//
//  ChatViewController.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/4.
//  Copyright © 2019 aliceyang. All rights reserved.
//
import UIKit

class ChatViewController: UIViewController{
    
    
    
    let chatService = ChatService()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text = UIDevice.current.name
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
