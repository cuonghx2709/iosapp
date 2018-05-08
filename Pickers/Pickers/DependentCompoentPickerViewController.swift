//
//  DependentCompoentPickerViewController.swift
//  Pickers
//
//  Created by cuonghx on 4/21/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class DependentCompoentPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: properties
    private let stateCompoment = 0
    private let zipCompoment = 1
    private var statZips: [String: [String]]!
    private var states: [String]!
    private var zips: [String]!
    @IBOutlet weak var dependentPicker: UIPickerView!
    
    //MARK: Picker Data Source Method
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == stateCompoment{
            return states.count
        }else{
            return zips.count
        }
    }
    
    // MARK: Delegate Picker method
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == stateCompoment {
            return states[row]
        }else {
            return zips[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("abcd")
        if component == stateCompoment {
            let selectedState = states[row]
            zips = statZips[selectedState]
            dependentPicker.reloadComponent(zipCompoment)
            dependentPicker.selectRow(0, inComponent: zipCompoment, animated: true)
        }
    }
    
    // setting witch
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    
        let pickerWidth = pickerView.bounds.size.width
        if component == 0{
            return pickerWidth / 3 // set comppment 1 1/3
        }else{
            return 2 * pickerWidth / 3
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bundle = Bundle.main
        
        let plistURl = bundle.url(forResource: "statedictionary", withExtension: "plist") // name: statedictionary and type is plist return full url //usr//m...statedcitiondary.split
        statZips = NSDictionary.init(contentsOf: (plistURl)! ) as! [String :[String]] // convert to dictiondary
        let allStates = statZips.keys
        states = allStates.sorted()
        let selectedState = states[0]
        zips = statZips[selectedState]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        let stateRow = dependentPicker.selectedRow(inComponent: stateCompoment)
        let zipRow = dependentPicker.selectedRow(inComponent: zipCompoment)
        let state = states[stateRow]
        let zip = zips[zipRow]
        
        let title = "You selected zip code \(zip)"
        let messeage = "\(zip) in \(state)"
        
        let alert = UIAlertController(title: title, message: messeage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
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
