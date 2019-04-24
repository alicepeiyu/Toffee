//
//  ToffeeTextMessageModel.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//
import Foundation
import ChattoAdditions

public class ToffeeTextMessageModel: TextMessageModel<MessageModel>, ToffeeMessageModelProtocol {
    public override init(messageModel: MessageModel, text: String) {
        super.init(messageModel: messageModel, text: text)
    }
    
    public var status: MessageStatus {
        get {
            return self._messageModel.status
        }
        set {
            self._messageModel.status = newValue
        }
    }
}
