//
//  ViewController.swift
//  Weather
//
//  Created by cuonghx on 4/30/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDeg: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var listForcast  = [Forcast]()
    var list = [ForcastDay]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        parseData(location: "Nam Dinh")
        let xib = UINib(nibName: "Cell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = 65
    }
    
    func parseData(location: String){
        var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast")
        url?.queryItems = [URLQueryItem(name: "q", value: location), URLQueryItem(name: "APPID", value: apiKey)]
        
        var request = URLRequest(url: (url?.url)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            if (err != nil){
                print("err")
            }else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                    let data = fetchedData as! [String: Any]
                    let context = DataModels(data: data)
                    self.labelName.text = context.name
                    self.labelDeg.text = "\(Int(context.temp)) °C"
                    //                    print(fetchedData)
                    self.listForcast = context.listForcast
                    self.list = context.list
                    self.tableView.reloadData()
                }
                    
                catch {
                    print("Err 2")
                }
            }
        })
        task.resume()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("abcd")
        parseData(location: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    // MARK: Data Source Method
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list[section].day
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.labelTemp.text = list[indexPath.section].list[indexPath.row].temp
        cell.labelMain.text = list[indexPath.section].list[indexPath.row].main
        cell.labeliDiscription.text = list[indexPath.section].list[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
}

