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
    
    // MARK: Get User Name
    func getUserName(forUID uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (_userSnapshot) in
            guard let userSnapshot = _userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                if user.key == uid {
                handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    // MARK: Get Email
    func getEmailForSearchQuery(query: String, handler: @escaping (_ result: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    // MARK: Get ids
    func getIds(forUserNames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        var idArray = [String]()
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let usersnp = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersnp {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    
    // MARK: Create a group
    func createGroup(withTitle title: String, withDiscription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    // Get group
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        
        var groupsArray = [Group]()
        
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnap) in
            guard let groupSnapshot = groupSnap.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                let title = group.childSnapshot(forPath: "title").value as! String
                let desc = group.childSnapshot(forPath: "description").value as! String
                
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let group = Group(groupTitle: title, groupDesc: desc, groupID: group.key, groupMemberCount: memberArray.count, groupMembers: memberArray)
                    groupsArray.append(group)
                }
            }
            handler(groupsArray)
        }
    }
}
