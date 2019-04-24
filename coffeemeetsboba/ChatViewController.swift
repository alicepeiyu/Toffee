//
//  ChatViewController.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/8.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import Chatto
import ChattoAdditions

class ChatViewController: BaseChatViewController, ChatServiceDelegate {

    var peer : MCPeerID?
    var chatService: ChatService?
    var messageSender: ChatMessageSender!
    let messagesSelector = BaseMessagesSelector()
    
    lazy private var baseMessageHandler: BaseMessageHandler = {
        return BaseMessageHandler(messageSender: self.messageSender, messagesSelector: self.messagesSelector)
    }()
    
    var dataSource: ChatDataSource! {
        didSet {
            self.chatDataSource = self.dataSource
            self.messageSender = self.dataSource.messageSender
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.chatService!.delegate = self
        // Do any additional setup after loading the view.
//        self.messagesSelector.delegate = self
        
        self.chatItemsDecorator = ToffeeChatItemsDecorator(messagesSelector: self.messagesSelector)
    }
    
    var chatInputPresenter: BasicChatInputBarPresenter!
    
    override func createChatInputView() -> UIView {
        let chatInputView = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        appearance.sendButtonAppearance.title = NSLocalizedString("Send", comment: "")
        appearance.textInputAppearance.placeholderText = NSLocalizedString("Type a message", comment: "")
        self.chatInputPresenter = BasicChatInputBarPresenter(chatInputBar: chatInputView, chatInputItems: self.createChatInputItems(), chatInputBarAppearance: appearance)
        chatInputView.maxCharactersCount = 1000
        return chatInputView
    }
    
    func createChatInputItems() -> [ChatInputItemProtocol] {
        var items = [ChatInputItemProtocol]()
        items.append(self.createTextInputItem())
//        items.append(self.createPhotoInputItem())
        return items
    }
    
    private func createTextInputItem() -> TextChatInputItem {
        let item = TextChatInputItem()
        item.textInputHandler = { [weak self] text in
            // Your handling logic
            if (self?.chatService?.sendData(text: text, toPeer: self!.peer!))!{
                self?.dataSource.addTextMessage(text, success: true)
            }
            else{
                print("Could not send data")
                self?.dataSource.addTextMessage(text, success : false)
            }
            }
        return item
    }
    
//    private func createPhotoInputItem() -> PhotosChatInputItem {
//        let item = PhotosChatInputItem(presentingController: self)
//        item.photoInputHandler = { [weak self] image in
//            // Your handling logic
//        }
//        return item
//    }
    
     override func createPresenterBuilders() -> [ChatItemType: [ChatItemPresenterBuilderProtocol]] {
        let textMessagePresenter = TextMessagePresenterBuilder(
            viewModelBuilder: ToffeeTextMessageViewModelBuilder(),
            interactionHandler: GenericMessageHandler(baseHandler: self.baseMessageHandler)
        )
        textMessagePresenter.baseMessageStyle = BaseMessageCollectionViewCellAvatarStyle()

        
        return [
            ToffeeTextMessageModel.chatItemType: [textMessagePresenter]
        ]
    }
    func receiveMessage(text: String) {
        self.dataSource.addIncomingTextMessage(text)
    }
    
    func foundPeer() {
        
    }
    
    func lostPeer() {
        
    }
    
    func invitationWasReceived(peerID: MCPeerID) {
        
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        
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
