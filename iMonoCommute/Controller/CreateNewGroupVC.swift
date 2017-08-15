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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(CreateNewGroupVC.textFieldDidChange), for: .editingChanged)
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
        cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        return cell
    }
}

extension CreateNewGroupVC: UITextFieldDelegate {
    
}
