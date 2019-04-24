//
//  BaseMessageCollectionViewCellAvatarStyle.swift
//  coffeemeetsboba
//
//  Created by Tobey Yang on 2019/4/23.
//  Copyright © 2019 aliceyang. All rights reserved.
//

import Foundation
import ChattoAdditions

class BaseMessageCollectionViewCellAvatarStyle: BaseMessageCollectionViewCellDefaultStyle {
    override func avatarSize(viewModel: MessageViewModelProtocol) -> CGSize {
        // Display avatar for both incoming and outgoing messages for demo purpose
        return CGSize(width: 35, height: 35)
    }
}

