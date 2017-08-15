//
//  CreateNewGroupVC.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit
import Firebase

class CreateNewGroupVC: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var listOfAddedUsersLabel: UILabel!
    @IBOutlet weak var emailSearchTextField: UITextField!
    
    // Variable
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(CreateNewGroupVC.textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButtonOutlet.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmailForSearchQuery(query: emailSearchTextField.text!, handler: { (emailCollection) in
                self.emailArray = emailCollection
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        if nameTextField.text != "" && descriptionTextField.text != "" {
            DataService.instance.getIds(forUserNames: chosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.nameTextField.text!, withDiscription: self.descriptionTextField.text!, forUserIds: userIds, handler: { (success) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Group coud not be created")
                    }
                })
            })
        }
    }
}

extension CreateNewGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
             cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
             cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !chosenUserArray.contains(cell.emailLabel.text!) {
            chosenUserArray.append(cell.emailLabel.text!)
            listOfAddedUsersLabel.text = chosenUserArray.joined(separator: ", ")
            doneButtonOutlet.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter { $0 != cell.emailLabel.text! }
            cell.isShowing = false
            if chosenUserArray.count >= 1 {
                listOfAddedUsersLabel.text = chosenUserArray.joined(separator: ", ")
            } else {
                listOfAddedUsersLabel.text = "add people to your group"
                doneButtonOutlet.isHidden = false
            }
        }
        tableView.reloadData()
    }
}

extension CreateNewGroupVC: UITextFieldDelegate {
    
}
