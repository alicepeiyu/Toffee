//
//  ChatViewController.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/4.
//  Copyright © 2019 aliceyang. All rights reserved.
//
import UIKit
import MultipeerConnectivity
import Chatto
import ChattoAdditions

class FindPeerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChatServiceDelegate{
    
    
    @IBOutlet weak var peerTable: UITableView!
    
    var chatService = ChatService()
    
    var selectedPeer : MCPeerID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chatService.delegate = self
        peerTable.delegate = self
        peerTable.dataSource = self
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatService.foundPeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("cellForRowAt")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "peerCell") as? peerCell{
            NSLog("PeerCell")
            cell.nameLabel.text = chatService.foundPeers[indexPath.row].displayName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPeer = chatService.foundPeers[indexPath.row]
        performSegue(withIdentifier: "goToChatView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? ChatViewController{
                dest.peer = selectedPeer
                dest.chatService = self.chatService
            }
        }
    }
    
    // MARK: - ChatServiceDelegate
    
    func foundPeer() {
        peerTable.reloadData()
    }
    
    func lostPeer() {
        peerTable.reloadData()
    }
    
    func invitationWasReceived(fromPeer: String){
        
    }
    
    func connectedWithPeer(peerID: MCPeerID){
        
    }
    
}

class peerCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
}
