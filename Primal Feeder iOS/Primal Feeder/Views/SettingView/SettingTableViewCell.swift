//
//  SettingTableViewCell.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/5/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        switchControl.onTintColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    }
    
    required init?(coder aDcoder: NSCoder) {
        fatalError("Error in init")
    }

    @objc func handleSwitchAction(sender: UISwitch) {
        if sender.isOn {
            print("Turned on")
        } else {
            print("Turned off")
        }
    }
}
