//
//  Message.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class Message {
    
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content: String, senderId: String) {
        self._senderId = senderId
        self._content = content
    }
}
