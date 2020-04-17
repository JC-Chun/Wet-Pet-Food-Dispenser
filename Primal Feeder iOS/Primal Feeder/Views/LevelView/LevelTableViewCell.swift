//
//  LevelTableViewCell.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/1/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var levelImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        levelView.layer.cornerRadius = 10
//        levelView.clipsToBounds = true
//        levelView.layer.shadowColor = UIColor.black.cgColor
//        levelView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        levelView.layer.shadowOpacity = 0.2
//        levelView.layer.shadowRadius = 5.0
    }

    func setup(list: FeederLevel) {
        
        levelLabel.text = list.level + "% Remaining"
        if list.title == "Nuggets" {
            levelImageView.image = #imageLiteral(resourceName: "nuggets")
        } else {
            levelImageView.image = #imageLiteral(resourceName: "water")
        }
        
    }
}
