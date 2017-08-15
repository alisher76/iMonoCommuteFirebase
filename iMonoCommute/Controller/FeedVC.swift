//
//  FeedVC.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    // Outlet
    @IBOutlet weak var tableView: UITableView!
    
    // Variable
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getAllFeedMessages { (messages) in
            self.messageArray = messages
            self.tableView.reloadData()
        }
    }
    
}

extension FeedVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell {
            cell.messageLabel.text = messageArray[indexPath.row].content
            cell.nameLabel.text = messageArray[indexPath.row].senderId
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

