//
//  SettingViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/15/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var settingTableView: UITableView!
    
    let settingList = ["Account",
                       "Device",
                       "WiFi",
                       "Notification"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.rowHeight = 50
    }

}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "settingHeaderCell") as! SettingHeaderTableViewCell

        cell.contentView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
            //as! SettingTableViewCell
        cell.textLabel?.text = settingList[indexPath.row]
        
        return cell
    }
    
    
}
