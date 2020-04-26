//
//  ViewController.swift
//  Primal Feeder
//
//  Created by Jacey Chun on 3/26/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit

class PetProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var petName: UITextField!
    @IBOutlet weak var petType: UITextField!
    @IBOutlet weak var petWeight: UITextField!
    @IBOutlet weak var startBtn: UIButton!

    var activeTextField: UITextField? = nil
    let name = ""
    let type = ["Dog", "Cat", "Other"]
    let weight = Measurement(value: 0.0, unit: UnitMass.pounds)
    
    let typePicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typePicker.delegate = self
        typePicker.dataSource = self
        configureTextField()
        configureTap()
        typePickView()
        petName.autocapitalizationType = .words
        addDoneButtonOnKeyboard()
        
        // call keyboardWillShow
        NotificationCenter.default.addObserver(self, selector: #selector(PetProfileViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification,  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PetProfileViewController.keyboardWillHide), name: UIResponder.keyboardWillShowNotification,  object: nil)
            
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      // set the activeTextField to the selected textfield
      self.activeTextField = textField
    }
      
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
      self.activeTextField = nil
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available, don't do anything.
            return
        }
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
          let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
          let topOfKeyboard = self.view.frame.height - keyboardSize.height

          // if the bottom of Textfield is below the top of keyboard, move up
          if bottomOfTextField > topOfKeyboard {
            shouldMoveViewUp = true
          }
        }
        if(shouldMoveViewUp) {
          self.view.frame.origin.y = 0 - keyboardSize.height
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
           self.view.frame.origin.y = 0
       }
    
    func configureTextField() {
        petName.delegate = self
        petType.delegate = self
        petWeight.delegate = self
    }
    
    func configureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(PetProfileViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func petNameTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveAndStart(_ sender: Any) {
        UserDefaults.standard.set(petName.text, forKey: "PetName")
        UserDefaults.standard.set(petType.text, forKey: "PetType")
        UserDefaults.standard.set(petWeight.text, forKey: "PetWeight")

    }
    
    /// funcitons for petType
    func typePickView() {
        let typeBar = UIToolbar()
        typeBar.sizeToFit()
        
        // done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        typeBar.setItems([doneButton], animated: true)
        petType.inputAccessoryView = typeBar
        petType.inputView = typePicker
    }
    
    @objc func donePressed() {
        self.view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return type.count
        } else {
            return 0
        }
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return type[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let typeSelected = type[pickerView.selectedRow(inComponent: 0)]
        petType.text = typeSelected
    }
    
    // format pet weight
    func weightFormatter() {
        let locale = Locale(identifier: "en_US")
        let formatter = MassFormatter()
        formatter.numberFormatter.locale = locale
        formatter.numberFormatter.maximumFractionDigits = 1
        
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        petWeight.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        petWeight.resignFirstResponder()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        petWeight.resignFirstResponder()
//    }
}


extension PetProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
