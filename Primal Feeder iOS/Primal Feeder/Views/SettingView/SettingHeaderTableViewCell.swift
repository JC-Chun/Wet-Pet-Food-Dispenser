//
//  SettingHeaderTableViewCell.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/6/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class SettingHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var settingHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingHeaderLabel.text = "Settings"
    }

}
