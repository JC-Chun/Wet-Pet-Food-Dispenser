//
//  ScheduleViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/8/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickDateAndTime: UITextField!
    @IBOutlet weak var pickPortion: UITextField!
    @IBOutlet weak var scheduleBtn: UIButton!
    
    let datePicker = UIDatePicker()
    let portionPicker = UIPickerView()
    let formatter = DateFormatter()
    let portionFraction =
        [" ","1/8","1/4","3/8","1/2","5/8","3/4","7/8"]
    let portionInt = [" ","1","2","3","4","5","6","7","8"]
    
    var newDate: Date!
    var newPortion: String!

    let notificationPublisher = NotificationPublisher()
    
    override func viewDidLoad() {
        
        portionPicker.delegate = self
        portionPicker.dataSource = self
        scheduleBtn.layer.cornerRadius = 10
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
        
        super.viewDidLoad()
        datePickerView()
        portionPickView()
        
    }
    
    // functions for pickDateAndTime
    func datePickerView() {
        let dateBar = UIToolbar()
        dateBar.sizeToFit()
        
        // done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDonePressed))
        dateBar.setItems([doneButton], animated: true)
        pickDateAndTime.inputAccessoryView = dateBar
        pickDateAndTime.inputView = datePicker
        
        datePicker.datePickerMode = .dateAndTime
        
    }
    
    @objc func dateDonePressed() {
        newDate = datePicker.date
        pickDateAndTime.text = self.formatter.string(from: newDate)
        self.view.endEditing(true)
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
        // prepare segue to popup
        if segue.destination is SchedulePopUpViewController {
            let vc = segue.destination as? SchedulePopUpViewController
            vc?.popUpTitle = "Scheduled!"
            vc?.popUpBody = newPortion + " will be dispensed \n on " + formatter.string(from: newDate) + "."
            vc?.btnTitle = "Done"
        }
    }
    @IBAction func pressedToSchedule(_ sender: Any) {
        // actions wehn 'Press to Schedule' button is pressed
        let newMeal = MealList(dateAndTime: newDate, portion: newPortion)
        
        Schedule.createMeal(index: 0, mealList: newMeal)
        print(Data.mealSchedules[0].mealList)
    }
}
    



