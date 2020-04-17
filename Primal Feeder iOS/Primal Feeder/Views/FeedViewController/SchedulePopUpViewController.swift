//
//  SchedulePopUpViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 4/14/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class SchedulePopUpViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var scheduleLabel: UILabel!
    
    var popUpTitle = ""
    var popUpBody = ""
    var btnTitle = ""
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.backgroundColor = #colorLiteral(red: 0.02745098039, green: 0.03921568627, blue: 0.137254902, alpha: 1)
        popUpView.layer.cornerRadius = 10
            
        titleLabel.textColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        titleLabel.text = popUpTitle
        scheduleLabel.textColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        scheduleLabel.text = popUpBody
        
        doneBtn.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        doneBtn.layer.cornerRadius = 10
        doneBtn.setTitle(btnTitle, for: .normal)
        if btnTitle == "Cancel" {
            doneBtn.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            dispensed()
        } else {
            doneBtn.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
        }
        formatter.dateFormat = "MMM dd, yyyy h:mm a"
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func dispensed() {
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.titleLabel.text = "Food Dispensed!"
            self.scheduleLabel.text = self.formatter.string(from: Date())
            self.doneBtn.backgroundColor = #colorLiteral(red: 0.5490196078, green: 0.7215686275, blue: 0.7843137255, alpha: 1)
            self.doneBtn.setTitle("Done", for: .normal)
        }
    }
    
    

}
