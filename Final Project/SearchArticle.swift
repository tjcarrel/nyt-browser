//
//  SearchArticle.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/3/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SearchArticle {
    
    var url: String
    var headline: String
    var snippet: String
    var date: String
    var section: String
    var thumbnail: UIImage!
    var largeImage: UIImage!
    
    let pre_url = "https://static01.nyt.com/"
    
    init(json: JSON){
        
        url = json["web_url"].stringValue
        headline = json["headline"]["main"].stringValue
        snippet = json["snippet"].stringValue
        section = json["section_name"].stringValue
        let multimedia = json["multimedia"].arrayValue
        
        let dateValue = json["pub_date"].stringValue
        let mySubstring = dateValue.prefix(10)
        date = String(mySubstring)
        
        for json in multimedia {
            if (json["subtype"].stringValue == "thumbnail") {
                if let link = json["url"].string {
                    if let url = URL(string: pre_url + link) {
                        if let data = try? Data(contentsOf: url) {
                            thumbnail = UIImage(data: data)!
                        }
                    }
                }
            }
            if (json["subtype"].stringValue == "xlarge") {
                if let link = json["url"].string {
                    if let url = URL(string: pre_url + link) {
                        if let data = try? Data(contentsOf: url) {
                            largeImage = UIImage(data: data)!
                        }
                    }
                }
            }
        }
    }
}
