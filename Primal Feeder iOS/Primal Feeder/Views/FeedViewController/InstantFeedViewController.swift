//
//  InstantFeedViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/12/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class InstantFeedViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var pickPortion: UITextField!
    @IBOutlet weak var scheduleBtn: UIButton!
    
    let portionPicker = UIPickerView()
    let formatter = DateFormatter()
    let portionFraction =
            ["","1/8","1/4","3/8","1/2","5/8","3/4","7/8"]
    let portionInt = ["","1","2","3","4","5","6","7","8"]
        
    var newPortion: String!

    let notificationPublisher = NotificationPublisher()
        
    override func viewDidLoad() {
            
        portionPicker.delegate = self
        portionPicker.dataSource = self
        scheduleBtn.layer.cornerRadius = 10
            
        super.viewDidLoad()
        portionPickView()
            
    }
        
        
    // functions for pickPortion
    func portionPickView() {
        let portionBar = UIToolbar()
        portionBar.sizeToFit()
            
        // done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(portionDonePressed))
            portionBar.setItems([doneButton], animated: true)
            pickPortion.inputAccessoryView = portionBar
            pickPortion.inputView = portionPicker
    }
        
    @objc func portionDonePressed() {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return portionInt.count
        case 1:
            return portionFraction.count
        default:
            return 1
        }
    }
        
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component{
        case 0:
            return portionInt[row]
        case 1:
            return portionFraction[row]
        default:
            return "cups"
        }
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let portionIntSelected = portionInt[pickerView.selectedRow(inComponent: 0)]
        let portionFractionSelected = portionFraction[pickerView.selectedRow(inComponent: 1)]
        if portionIntSelected == " " || portionIntSelected == "1" && portionFractionSelected == " "  {
            newPortion = "\(portionIntSelected) \(portionFractionSelected) cup"
            pickPortion.text = newPortion
        }
        else {
            newPortion = "\(portionIntSelected) \(portionFractionSelected) cups"
            pickPortion.text = newPortion
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SchedulePopUpViewController {
            let vc = segue.destination as? SchedulePopUpViewController
            vc?.popUpTitle = "Processing..."
            vc?.popUpBody = newPortion + " will be dispensed soon."
            vc?.btnTitle = "Cancel"
        
        }
    }
    @IBAction func pressedToSchedule(_ sender: Any) {
        let newMeal = MealList(dateAndTime: Date(), portion: newPortion)
        Schedule.createMeal(index: 1, mealList: newMeal)
        //
        //let currentDate = formatter.string(from: Date())
        notificationPublisher.sendLocalNotification(title: "Food has been dispensed!", body: newPortion + " ", badge: 1, delayInterval: 5)
    }
        
}
