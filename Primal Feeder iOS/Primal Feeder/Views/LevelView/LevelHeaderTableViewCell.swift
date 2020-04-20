//
//  LevelHeaderTableViewCell.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/1/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class LevelHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var levelHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        levelHeaderLabel.text = "Feeder Levels"
    }
}
