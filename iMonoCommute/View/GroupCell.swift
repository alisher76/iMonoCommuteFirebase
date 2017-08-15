//
//  GroupCell.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    // Outlets
    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    
    @IBOutlet weak var usersLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withTitle title: String, withGroupDescription description: String, withMemberCount members: Int) {
        self.groupTitle.text = title
        self.groupDescription.text = description
        self.usersLabel.text = "#of-members: \(members)"
    }
    
}
