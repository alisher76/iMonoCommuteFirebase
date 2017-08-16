//
//  GroupFeedVC.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sebdButtonOutlet: UIButton!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldAndButtonView: UIView!
    
    var group: Group?
    var messages = [Message]() {
        didSet {
            print(messages)
        }
    }
    
    func initData(forGroup group: Group) {
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textFieldAndButtonView.bindToKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group!.groupTitle
        DataService.instance.getEmails(forGroup: group!) { (returnedEmails) in
            print(returnedEmails.joined(separator: ", "))
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagsFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.messages = returnedGroupMessages
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sebdButtonOutlet.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.groupID, sendComplete: { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sebdButtonOutlet.isEnabled = true
                    self.tableView.reloadData()
                }
            })
        }
    }
    

}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {
            return UITableViewCell()
        }
        let message = messages[indexPath.row]
        
        DataService.instance.getUserName(forUID: message.senderId) { (email) in
        cell.configureCell(withContent: message.content, withEmail: email, withProfileImage: "defaultProfileImage")
        }
        return cell
    }
}
