//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Anatolii Tomazov on 16/11/2019.
//  Copyright © 2019 Anatolii Tomazov. All rights reserved.
//

import UIKit
import Foundation

class ConversionVIewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var celciusLabel: UILabel!
    
    var fahrenheitValue : Measurement<UnitTemperature>? {
        didSet {
            updateCelciusLabel()
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelciusLabel()
        print("Convert")
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setViewBackground()
    }
    
    func getCurrentHour() -> Int {
        let date = NSDate()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date as Date)
        return hour
    }
    
    func setViewBackground(){
        let currentHour = getCurrentHour()
        let eveningHour = 18
        
        if currentHour > eveningHour {
            view.backgroundColor = UIColor.gray
        }
    }
        
    
   
    
    @IBAction func fahrengeitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
           fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    
       var celsiusValue : Measurement<UnitTemperature>? {
           if let fahremnheitValue = fahrenheitValue {
               return fahrenheitValue?.converted(to: .celsius)
           } else {
               return nil
           }
       }
    
    func updateCelciusLabel() {
        if let celsiusValue = celsiusValue {
            celciusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celciusLabel.text="???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    
}
