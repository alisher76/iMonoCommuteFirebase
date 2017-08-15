//
//  DataService.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation
import Firebase

// Root to Firebase database
let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    // References
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping (_ status: Bool) -> ()) {
        if groupKey != nil {
            // send to groupd ref
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnap) in
            guard let feedMessageSnap = feedMessageSnap.children.allObjects as? [DataSnapshot] else { return }
            for message in feedMessageSnap {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let _message = Message(content: content, senderId: senderId)
                messageArray.append(_message)
            }
            handler(messageArray)
        }
    }
}
