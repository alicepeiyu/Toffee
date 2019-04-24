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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "peerCell") as? peerCell{
            cell.nameLabel.text = chatService.foundPeers[indexPath.row].displayName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedPeer = chatService.foundPeers[indexPath.row]
        self.chatService.invitePeer(peer: selectedPeer!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            if let dest = segue.destination as? ChatViewController{
                dest.peer = selectedPeer
                dest.chatService = self.chatService
                let dataSource = ChatDataSource(messages: [], pageSize: 50)
                dest.dataSource = dataSource
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
    
    func invitationWasReceived(peerID: MCPeerID){
        let alert = UIAlertController(title: "", message: "\(peerID.displayName) wants to chat with you.", preferredStyle: UIAlertController.Style.alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            self.chatService.invitationHandler(true, self.chatService.session)
            self.selectedPeer = peerID
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
            self.chatService.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID){
        performSegue(withIdentifier: "goToChatView", sender: self)
    }
    
    func receiveMessage(text: String){
        NSLog("receiveMessage")
    }
}

class peerCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
}
