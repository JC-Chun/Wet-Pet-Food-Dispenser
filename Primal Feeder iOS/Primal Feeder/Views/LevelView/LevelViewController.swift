//
//  LevelViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/15/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    
    @IBOutlet weak var levelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelTableView.dataSource = self
        levelTableView.delegate = self
        
        Level.getLevels(completion: { [weak self] in
            //completion
            self?.levelTableView.reloadData()
        })
    
    }
    
}
extension LevelViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: "levelHeaderCell") as! LevelHeaderTableViewCell

        cell.contentView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.feederLevels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = Data.feederLevels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell") as! LevelTableViewCell
        cell.setup(list: list)
        return cell
    }
    

}
