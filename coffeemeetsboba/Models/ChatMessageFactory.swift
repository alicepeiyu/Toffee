//
//  ChatMessageFactory.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/19.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ChatMessageFactory {
    class func makeTextMessage(_ uid: String, text: String, isIncoming: Bool, success: Bool) -> ToffeeTextMessageModel {
        let messageModel = self.makeMessageModel(uid, isIncoming: isIncoming, type: TextMessageModel<MessageModel>.chatItemType, success: success)
        let textMessageModel = ToffeeTextMessageModel(messageModel: messageModel, text: text)
        return textMessageModel
    }
    
    private class func makeMessageModel(_ uid: String, isIncoming: Bool, type: String, success: Bool) -> MessageModel {
        let senderId = isIncoming ? "1" : "2"
        let messageStatus = isIncoming || success ? MessageStatus.success : .failed
        return MessageModel(uid: uid, senderId: senderId, type: type, isIncoming: isIncoming, date: Date(), status: messageStatus)
    }
//    class func makePhotoMessage(_ uid: String, image: UIImage, size: CGSize, isIncoming: Bool) -> ToffeePhotoMessageModel {
//        let messageModel = self.makeMessageModel(uid, isIncoming: isIncoming, type: PhotoMessageModel<MessageModel>.chatItemType)
//        let photoMessageModel = ToffeePhotoMessageModel(messageModel: messageModel, imageSize: size, image: image)
//        return photoMessageModel
//    }
}
extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}

extension PhotoMessageModel {
    static var chatItemType: ChatItemType {
        return "photo"
    }
}

extension ChatItemType {
    static var compoundItemType = "compound"
}
