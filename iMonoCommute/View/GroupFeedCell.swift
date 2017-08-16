//
//  GroupFeedCell.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: CircleImage!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withContent content: String, withEmail email: String, withProfileImage profileImage: String) {
        self.messageLabel.text = content
        self.nameLabel.text = email
        self.profileImage.image = UIImage(named: profileImage)
    }
}
