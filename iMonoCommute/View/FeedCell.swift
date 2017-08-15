//
//  FeedCell.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: CircleImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
