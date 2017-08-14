//
//  ShadowView.swift
//  iMonoCommute
//
//  Created by Alisher Abdukarimov on 8/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }

}
