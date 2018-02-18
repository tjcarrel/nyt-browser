//
//  Data.swift
//  Final Project
//
//  Created by Theodore Carrel on 11/30/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article {
    
    var title: String
    var author: String
    var abstract: String
    var url: String
    var date: String
    var section: String
    var imageLink: String!
    var image: UIImage!
    
    
    init(json: JSON) {
        
        title = json["title"].stringValue
        author = json["byline"].stringValue
        abstract = json["abstract"].stringValue
        url = json["url"].stringValue
        section = json["section"].stringValue
        imageLink = json["media"].array?.first?["media-metadata"].array?[3]["url"].stringValue
        
        if let link = imageLink {
            if let url = URL(string: link) {
                if let data = try? Data(contentsOf: url) {
                    image = UIImage(data: data)
                }
            }
        }
        
        let tempDate = json["published_date"].stringValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let myDate = dateFormatter.date(from: tempDate)
        
        dateFormatter.dateFormat = "MMM dd, YYYY"
        date = dateFormatter.string(from: myDate!)
    }
        
    }

