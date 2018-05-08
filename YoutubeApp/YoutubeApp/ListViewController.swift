//
//  ListViewController.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/2/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: properties
    @IBOutlet var tableView: UITableView!
    var list : [YoutubeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.separatorStyle = .none
        let xib = UINib(nibName: "CellYoutube", bundle: nil)
        self.tableView.register(xib, forCellReuseIdentifier: "CellYoutube")
        self.tableView.rowHeight = 100
        self.automaticallyAdjustsScrollViewInsets = false
        setupNavigation()
//        let app = UIApplication.shared
//        NotificationCenter.default.addObserver(self, selector: #selector(getDatabases), name: NSNotification.Name.UIApplicationWillEnterForeground, object: app)
        getDatabases()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        getDatabases()
//    }
    func setupNavigation(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(onNextPressed))
    }
    @objc func onNextPressed() {
        pushNext()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellYoutube", for: indexPath) as! YoutubeCell
        cell.labelDiscription.text = list[indexPath.row].description
        cell.labelTitle.text = list[indexPath.row].title
        cell.imageVideo.kf.setImage(with: NSURL(string: list[indexPath.row].urlImage)! as URL)
        return cell
    }
    
    //MARK: TableView Data Delegate
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let sheet = UIAlertController(title: "Lựa chọn", message: nil, preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Hát trước", style: .default) { (action) in
            pushOnTopByID(id: self.list[indexPath.row].videoId)
        }
        let actionDelete = UIAlertAction(title: "Xoá", style: .default) { (action) in
            removeByID(id: self.list[indexPath.row].videoId, indexPath: indexPath)
        }
        let actionRev = UIAlertAction(title: "Xem thử", style: .default) { (action) in
            print("open new scence")
//           let viewController = ViewController()
//            self.navigationController?.pushViewController(viewController, animated: true)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newController = storyboard.instantiateViewController(withIdentifier: "youtubeView") as! ViewController
            newController.idVideo = self.list[indexPath.row].videoId
            self.navigationController?.pushViewController(newController, animated: true)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        sheet.addAction(actionRev)
        sheet.addAction(action)
        sheet.addAction(actionDelete)
        sheet.addAction(actionCancel)
        
        //show(sheet, sender: nil)
        self.present(sheet, animated: true, completion: nil)
        return nil
    }
    
    //MARK: Get DataFrom Firebase
    @objc func getDatabases(){
        print("getdata")
        var listYoutube = [YoutubeModel]()
        ref = Database.database().reference(withPath: "YoutubeModel")
        ref.observe(.value, with: { (snapshot) in
            if (snapshot.childrenCount > 0){
                let dictiondary = snapshot.value as! NSDictionary
                for dic in dictiondary.allValues {
                    let list = (dic as! [String: Any])["list"] as! NSArray
                    listYoutube = []
                    for item in list{
                        let i = item as! [String: Any]
                        listYoutube.append(YoutubeModel(videoId: i["id"] as! String, urlImage: i["thumbnailURL"] as! String, title: i["title"] as! String, description: i["description"] as! String))
                    }
                }
                self.list = listYoutube
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            }else{
                self.list = []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
//                    self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            }
        })
    }
}
