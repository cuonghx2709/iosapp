//
//  SearchViewController.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/1/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    // MARK: properties
    var listYoutube = [YoutubeModel]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load xib
        let xib = UINib(nibName: "CellYoutube", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CellYoutube")
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        searchByString(search: "viet mix")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: SearchBar Method
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchByString(search: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    // MARK: Youtube Api method
    func searchByString(search: String) {
        print("searching")
        self.listYoutube = []
        var url = URLComponents(string: "https://www.googleapis.com/youtube/v3/search")
        url?.queryItems = [URLQueryItem(name: "part", value: "id,snippet"), URLQueryItem(name: "fields", value: fields), URLQueryItem(name: "q", value: search), URLQueryItem(name: "type", value: "video"), URLQueryItem(name: "maxResults", value: "50"), URLQueryItem(name: "key", value: apiKey)]
        
        var request = URLRequest(url: (url?.url)!)
        request.httpMethod = "GET"
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, err) in
            if err != nil {
                print("Error")
            }else {
                let fetCheData = try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves)
                let dataObject = fetCheData as! [String: Any]
                let items = dataObject["items"] as! NSArray
                
                for item in items {
                    
                    let d = item as! [String : Any]
                    let id = d["id"] as! [String: Any]
                    //                    print(id["videoId"]!)
                    let snippet = d["snippet"] as! [String: Any]
                    //                    print(snippet["title"]!)
                    //                    print(snippet["description"]!)
                    let thumnail = snippet["thumbnails"] as! [String: Any]
                    let high = thumnail["high"] as! [String: Any]
                    //                    print(high["url"]!)
                    
                    let youtubeModel = YoutubeModel(videoId: id["videoId"] as! String, urlImage: high["url"] as! String, title: snippet["title"] as! String, description: snippet["description"] as! String)
                    self.listYoutube.append(youtubeModel)
                    
                }
                print(self.listYoutube.count)
//                self.tableView.reloadData()
    
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.contentOffset = .zero
                    self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top , animated: true)
                    
                }
            }
        })
        task.resume()
        
    }
    
    // MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listYoutube.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellYoutube", for: indexPath) as! YoutubeCell
        configureCell(cell: cell, atIndexPath: indexPath)
        return cell
    }
    
    private func configureCell(cell: YoutubeCell, atIndexPath indexPath: IndexPath){
        
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async {
                cell.labelTitle.text = self.listYoutube[indexPath.row].title
                cell.labelDiscription.text = self.listYoutube[indexPath.row].description
//                let data = NSData(contentsOf: URL(string: self.listYoutube[indexPath.row].urlImage)!)
//                cell.imageVideo.image = UIImage(data: data! as Data)
                let url = NSURL(string: self.listYoutube[indexPath.row].urlImage)
                cell.imageVideo.kf.setImage(with: url! as URL)
                
//                let data = try! Data(contentsOf: URL(string: self.listYoutube[indexPath.row].urlImage)!)
            }
        }
        
    }
    
    // MARK: TableView Source
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let alert = UIAlertController(title: "Selected", message: "Are you sure?", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Yes", style: .cancel, handler: {
            (action) in
            pushDatabase(youtubeMode: self.listYoutube[indexPath.row])
        })
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
//        let action = UIAlertAction(title: "Xem thử", style: .default, handler: nil)
//        alert.addAction(action)
        alert.addAction(alertAction)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: true, completion: nil)
        return nil
    }

}
