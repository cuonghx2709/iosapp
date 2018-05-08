//
//  DoubleCompoentPickerViewController.swift
//  Pickers
//
//  Created by cuonghx on 4/21/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class DoubleCompoentPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK:Properties
    let character =  [
        "Luke", "Leia", "Han", "Chewbacca", "Artoo",
        "Threepio", "Lando"]
    let otherArray = ["cuong", "hoang", "xuan"]
    
    @IBOutlet weak var doublePicker: UIPickerView!
    
    // MARK: picker method data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return character.count
        }else{
            return otherArray.count
        }
    }
    //MARK picker Method Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return character[row]
        }else{
            return otherArray[row]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let row1 = doublePicker.selectedRow(inComponent: 0)
        let row2 = doublePicker.selectedRow(inComponent: 1)
        
        let selected = character[row1]
        let selected2 = otherArray[row2]
        
        let title = "You selected \(selected), \(selected2)"
        let alert = UIAlertController(title: title, message: "Thank you", preferredStyle: .alert)
        let  action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
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
