//
//  MealListViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/25/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var mealListTableView: UITableView!
    
    private let notification = NotificationPublisher()
    
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        mealListTableView.dataSource = self
        mealListTableView.delegate = self
        
        Schedule.listMeal(completion: { [weak self] in
            //completion
            self?.mealListTableView.reloadData()
        })
        
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        //let currentDate = formatter.string(from: Date())
        // test notification
        //notification.sendLocalNotification(title: "Food has been dispensed!", body: "2 1/2 cups at \(currentDate)", badge: 1, delayInterval: 30)
    }
}

extension MealViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Data.mealSchedules.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // set up headers
        let mealSchedule = Data.mealSchedules[section]

        let cell = tableView.dequeueReusableCell(withIdentifier: "mealListHeaderCell") as! MealListHeaderTableViewCell

        cell.setup(list: mealSchedule)
        cell.contentView.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        return cell.contentView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns how many rows (data) are for the table view
        return Data.mealSchedules[section].mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mealListCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "mealListCell")
        }
        
        //formatter.dateFormat = "MMM dd, yyyy h:mm a"
        cell?.textLabel?.text = //"\(Data.mealSchedules[indexPath.section].mealList[indexPath.row].dateAndTime)"
            formatter.string(from: Data.mealSchedules[indexPath.section].mealList[indexPath.row].dateAndTime)

        cell?.detailTextLabel?.text = "\(Data.mealSchedules[indexPath.section].mealList[indexPath.row].portion)" + " cups"
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // swipe left to delete
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (UIContextualAction, view, actionPerformed: @escaping (Bool) -> ()) in

            let alert = UIAlertController(title: "Delete Meal", message: "Are you sure you want to delete this meal?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(alertAction) in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {(alertAction) in
                Schedule.swipeDeleteMeal(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)

            }))
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // swipe right to edit
//        let edit = UIContextualAction(style: .normal, title: "Edit") { (UIContextualAction, view, actionPerformed: (Bool) -> ()) in
//            self.performSegue(withIdentifier: "", sender: nil) // to Schedule.createMeal function
//            actionPerformed(true)
//        }
//        edit.backgroundColor = #colorLiteral(red: 0.831372549, green: 0.8901960784, blue: 0.5607843137, alpha: 1)
//        return UISwipeActionsConfiguration(actions: [edit])
//    }
    
    
    
}

