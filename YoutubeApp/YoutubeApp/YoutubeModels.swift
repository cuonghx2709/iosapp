//
//  YoutubeModels.swift
//  YoutubeApp
//
//  Created by cuonghx on 5/1/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import Foundation
class YoutubeModel{
    var videoId: String
    var urlImage: String
    var title: String
    var description: String
    
    init(videoId: String, urlImage: String, title: String, description: String) {
        self.videoId = videoId
        self.urlImage = urlImage
        self.title = title
        self.description = description
    }
}
class FireBaseModelYoutube{
    var list: [YoutubeModel]
    init(list: [YoutubeModel]) {
        self.list = list
    }
    
    var dict:[String:Any] {
        
        return [
            "list": getList()
        ]
    }
    
    func getList() -> [[String: Any]] {
        var r = [[String: Any]]()
        
        for index in 0..<list.count{
            let item = list[index]
            var content = [String: Any]()
            content["id"] = item.videoId
            content["thumbnailURL"] = item.urlImage
            content["description"] = item.description
            content["title"] = item.title
            r.append(content)
        }
        return r
    }
}
