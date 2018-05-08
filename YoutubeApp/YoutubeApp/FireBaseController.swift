//
//  FireBaseController.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/2/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import Foundation
import Firebase

var ref: DatabaseReference!

func login(){
    Auth.auth().signIn(withEmail: mail, password: p) { (usr, err) in
//        print(usr)
//        print(getDatabases().count)
//        pushDatabase(youtubeMode: YoutubeModel(videoId: "abcd", urlImage: "abcd", title: "abcd", description: "abcd"))
    }
}

func getDatabases(){
    var listYoutube = [YoutubeModel]()
    ref = Database.database().reference(withPath: "YoutubeModel")
    ref.observeSingleEvent(of: .value) { (snapshot) in
        let dictiondary = snapshot.value as! NSDictionary
        for dic in dictiondary.allValues {
            let list = (dic as! [String: Any])["list"] as! NSArray
            
            for item in list{
                let i = item as! [String: Any]
                listYoutube.append(YoutubeModel(videoId: i["id"] as! String, urlImage: i["thumbnailURL"] as! String, title: i["title"] as! String, description: i["description"] as! String))
            }
        }
    }
}
func pushDatabase(youtubeMode: YoutubeModel){
    ref = Database.database().reference(withPath: "YoutubeModel")
    ref.observeSingleEvent(of: .value) { (datasnapshot) in
        if datasnapshot.childrenCount > 0{
            let dictiondary = datasnapshot.value as! NSDictionary
            for (key, value) in dictiondary{
                let list = (value as! [String: Any])["list"] as! NSArray
                var newlist = [YoutubeModel]()
                
                for item in list{
                    let content = item as! [String: Any]
                    
                    newlist.append(YoutubeModel(videoId: content["id"] as! String, urlImage: content["thumbnailURL"] as! String, title: content["title"] as! String, description: content["description"] as! String))
                }
                //            print(list[0])
                newlist.append(youtubeMode)
                print(newlist.count)
                
                let fireBaseModel = FireBaseModelYoutube(list: newlist)
                
                ref.child(key as! String).setValue(fireBaseModel.dict)
            }
        }else {
            var newlist = [YoutubeModel]()
            newlist.append(youtubeMode)
            let fireBaseModel = FireBaseModelYoutube(list: newlist)
            
            ref.childByAutoId().setValue(fireBaseModel.dict)
            
        }
        
    }
}

func removeByID(id: String, indexPath: IndexPath){
    ref = Database.database().reference(withPath: "YoutubeModel")
    ref.observeSingleEvent(of: .value) { (datasnapshot) in
        if datasnapshot.childrenCount > 0{
            let dictiondary = datasnapshot.value as! NSDictionary
            for (key, value) in dictiondary{
                let list = (value as! [String: Any])["list"] as! NSArray
                var newlist = [YoutubeModel]()
                
                for index in 0..<list.count {
                    let content = list[index] as! [String: Any]
                    if index != indexPath.row{
                        newlist.append(YoutubeModel(videoId: content["id"] as! String, urlImage: content["thumbnailURL"] as! String, title: content["title"] as! String, description: content["description"] as! String))
                    }
                    
                }
                
                let fireBaseModel = FireBaseModelYoutube(list: newlist)
                
                ref.child(key as! String).setValue(fireBaseModel.dict)
            }
        }else {
            print("else")
        }
        
    }
}

func pushOnTopByID(id: String){
    ref = Database.database().reference(withPath: "YoutubeModel")
    ref.observeSingleEvent(of: .value) { (datasnapshot) in
        if datasnapshot.childrenCount > 0{
            let dictiondary = datasnapshot.value as! NSDictionary
            for (key, value) in dictiondary{
                let list = (value as! [String: Any])["list"] as! NSArray
                var newlist = [YoutubeModel]()
                
                for item in list{
                    let content = item as! [String: Any]
                    newlist.append(YoutubeModel(videoId: content["id"] as! String, urlImage: content["thumbnailURL"] as! String, title: content["title"] as! String, description: content["description"] as! String))
                }
                
                for index in 0..<newlist.count{
                    if id == newlist[index].videoId {
                        let tmp = newlist[index];
                        newlist.remove(at: index)
                        newlist.insert(tmp, at: 0)
                        break
                    }
                }
                
                
                let fireBaseModel = FireBaseModelYoutube(list: newlist)
                
                ref.child(key as! String).setValue(fireBaseModel.dict)
            }
        }else {
            print("else")
        }
    }
}

func pushNext(){
    ref = Database.database().reference(withPath: "Status")
    ref.observeSingleEvent(of: .value) { (datasnapshot) in
        if datasnapshot.childrenCount > 0{
            let dictiondary = datasnapshot.value as! NSDictionary
            for (key, value) in dictiondary{
                let status = (value as! [String: Any])["status"] as! String
                if status == "play"{
                    let v = ["status": "next"]
                    ref.child(key as! String).setValue(v)
                }
            }
        }
    }
}

