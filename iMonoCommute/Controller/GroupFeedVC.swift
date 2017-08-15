//
//  GroupFeedVC.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {
    
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sebdButtonOutlet: UIButton!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldAndButtonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textFieldAndButtonView.bindToKeyboard()
        
    }
    
    @IBAction func goBackButtonTapped(_ sender: Any) {
      dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
    }
    

}

extension GroupFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else {
            return UITableViewCell()
        }
        return cell
    }
}
