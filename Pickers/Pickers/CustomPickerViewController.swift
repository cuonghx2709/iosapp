//
//  CustomPickerViewController.swift
//  Pickers
//
//  Created by cuonghx on 4/21/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var arr: [String] = ["1", "2", "3", "4" ," 5", "6", "7"," 8", "9"]
    @IBOutlet weak var customPicker: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    // MARK: Picker Delegate Method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        randromNumber()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randromNumber() {
        let n1 = Int(arc4random_uniform(UInt32(arr.count)))
        let n2 = Int(arc4random_uniform(UInt32(arr.count)))
        let n3 = Int(arc4random_uniform(UInt32(arr.count)))
        
        customPicker.selectRow(n1, inComponent: 0, animated: true)
        customPicker.selectRow(n2, inComponent: 1, animated: true)
        customPicker.selectRow(n3, inComponent: 2, animated: true)
        
        customPicker.reloadComponent(0)
        customPicker.reloadComponent(1)
        customPicker.reloadComponent(2)
    }
    @IBAction func onButtonPressed(_ sender: UIButton) {
        randromNumber()
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
