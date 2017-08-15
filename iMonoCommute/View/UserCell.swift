//
//  UserCell.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var profileImage: CircleImage!
    @IBOutlet weak var checkmarkImage: CircleImage!
    @IBOutlet weak var emailLabel: UILabel!
    
    // Variable
    var isShowing = false
    
    func configureCell(profileImage: UIImage, email: String, isSelected: Bool) {
        
        self.profileImage.image = profileImage
        self.emailLabel.text = email
        
        if isSelected {
            self.checkmarkImage.isHidden = false
        } else {
            self.checkmarkImage.isHidden = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        if selected {
            if isShowing == false {
                checkmarkImage.isHidden = false
                isShowing = true
            }
        } else if !selected && isShowing == true {
            checkmarkImage.isHidden = true
            isShowing = false
        }
    }
}
