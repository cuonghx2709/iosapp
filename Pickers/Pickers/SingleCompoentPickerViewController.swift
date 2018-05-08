//
//  SingleCompoentPickerViewController.swift
//  Pickers
//
//  Created by cuonghx on 4/21/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class SingleCompoentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: properties
    @IBOutlet weak var picker: UIPickerView!
    
    private let characterName =  [
        "Luke", "Leia", "Han", "Chewbacca", "Artoo",
        "Threepio", "Lando"]
    
    // MARK: picker Data Source Method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // so luong picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characterName.count // so luong dong
    }
    
    // MARK: picker Delegate Method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characterName[row] // hien thi data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: action:
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let row = picker.selectedRow(inComponent: 0)
        let selected = characterName[row]
        
        
        let title = "You selected \(selected)"
        let alert = UIAlertController(title: title, message: "thank you", preferredStyle: .alert)
        let action = UIAlertAction(title: "You're welcome", style: .default, handler: nil)
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
