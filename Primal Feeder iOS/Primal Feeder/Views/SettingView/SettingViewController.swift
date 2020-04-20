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
    var userInfoHeader: UserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    func configureTableView() {
        settingTableView = UITableView()
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.rowHeight = 60
        
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "settingCell")
        view.addSubview(settingTableView)
        settingTableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfo(frame: frame)
        settingTableView.tableHeaderView = userInfoHeader
        settingTableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        let nav = navigationController?.navigationBar
        nav?.prefersLargeTitles = true
        nav?.tintColor = #colorLiteral(red: 0.02745098039, green: 0.03921568627, blue: 0.137254902, alpha: 1)

        let app = UINavigationBarAppearance()
        app.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        nav?.scrollEdgeAppearance = app
        navigationItem.title = "Settings"
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingSection(rawValue: section) else { return 0 }
        
        switch section {
        case .info: return InfoOptions.allCases.count
        case .communications: return CommunicationOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let headerCell = tableView.dequeueReusableCell(withIdentifier: "settingHeaderCell") as! SettingHeaderTableViewCell
//        headerCell.contentView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
//
        let sectionView = UIView()
        sectionView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = #colorLiteral(red: 0.02218869701, green: 0.04771179706, blue: 0.1831949651, alpha: 1)
        title.text = SettingSection(rawValue: section)?.description
        sectionView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: sectionView.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo:  sectionView.leftAnchor, constant: 16).isActive = true
        
        return sectionView
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
            as! SettingTableViewCell
        guard let section = SettingSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .info:
            let info = InfoOptions(rawValue: indexPath.row)
            cell.sectionType = info
        case .communications:
            let communication = CommunicationOptions(rawValue: indexPath.row)
            cell.sectionType = communication
        }
        return cell
    }
    
    
}
