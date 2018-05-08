//
//  DataModels.swift
//  Weather
//
//  Created by cuonghx on 4/30/18.
//  Copyright © 2018 cuonghx. All rights reserved.
//

import Foundation
class DataModels {
    var name: String
    var temp: Double
    var listForcast = [Forcast]()
    var list = [ForcastDay]()
    
    init(data: [String: Any]) {
        let city = data["city"] as! [String: Any]
        self.name = city["name"] as! String
        let list = data["list"] as! NSArray
        temp = 0
        
        var day = 0
        var forcast: ForcastDay = ForcastDay(day: "")
        
        for index in 0..<list.count{
            if index <= 0  {
                let current = list[index] as! [String : Any]
                let main = current["main"] as! [String : Any]
                temp = main["temp"] as! Double - 272.15
            }else{
                let current = list[index] as! [String : Any]
                let main = current["main"] as! [String : Any]
                let tmp = main["temp"] as! Double - 272.15
                let weather = current["weather"] as! NSArray
                let w = weather[0] as! [String : Any]
                
                let dateString = current["dt_txt"] as! String
                let formatDate = DateFormatter()
                formatDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
                formatDate.timeZone = TimeZone(secondsFromGMT: +7)
                let date = formatDate.date(from: dateString)!
                let calendar = NSCalendar.current
                
            
                if day == calendar.component(.day, from: date ){
                    forcast.pushForcast(forcast: Forcast(temp: "\(Int(tmp))°C", main: w["main"] as! String, description: w["description"] as! String))
                }else {
                    let month = calendar.component(.month, from: date)
                    day = calendar.component(.day, from: date )
                    forcast = ForcastDay(day: "\(day)/\(month)")
                    self.list.append(forcast)
                    forcast.pushForcast(forcast: Forcast(temp: "\(Int(tmp))°C", main: w["main"] as! String, description: w["description"] as! String))
                }
                
                listForcast.append(Forcast(temp: "\(Int(tmp))°C", main: w["main"] as! String, description: w["description"] as! String))
            }
        }
    }
}
class Forcast {
    var temp: String
    var main: String
    var description: String
    
    init(temp : String, main: String, description: String) {
        self.temp = temp
        self.main = main
        self.description = description
    }
    
}
class ForcastDay {
    var day: String
    var list = [Forcast]()
    init(day: String) {
        self.day = day
    }
    func pushForcast(forcast: Forcast){
        list.append(forcast)
    }
}

