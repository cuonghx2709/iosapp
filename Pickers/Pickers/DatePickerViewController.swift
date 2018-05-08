//
//  DatePickerViewController.swift
//  Pickers
//
//  Created by cuonghx on 4/21/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    // MARK: properties:
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = NSDate()
        datePicker.setDate(date as Date, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: action:
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        // Date Format cho đúng múi h
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm ZZZZ"
        let selectedDate = dateFormatter.string(from: datePicker.date)
        
        
        let message = "The date and time you select \(selectedDate)"
        
        let alert = UIAlertController(title: "Date and time Selected", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "That's so true", style: .cancel, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
