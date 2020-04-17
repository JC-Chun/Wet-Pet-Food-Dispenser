//
//  MealListHeaderTableViewCell.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/4/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class MealListHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(list: MealSchedule) {
        titleLabel.text = list.title
    }
}
