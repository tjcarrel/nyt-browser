//
//  NetworkManager.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/1/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let mostpopularURL = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=52cd8d9ad8cd4ff7be7538b4194cfd5c"
let searchURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
let search_apikey = "52cd8d9ad8cd4ff7be7538b4194cfd5c"

class NetworkManager {
    
    static func getPosts(completion: @escaping ([Article]) -> Void) {
        guard let url = URL(string: mostpopularURL) else { return }
        
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                
                let jsonArray = json["results"].arrayValue
                var articles: [Article] = []
                for json in jsonArray {
                    articles.append(Article(json: json))
                }
                
                completion(articles)
                
            case.failure(let error):
                print(error)
            }
        }
    }
    
    static func getSearch(text: String, completion: @escaping ([SearchArticle]) -> Void) {
        guard let url = URL(string: searchURL) else { return }
        
        let params = ["q": text] as [String : Any]
        let headers = ["api-key": search_apikey]
        
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { response in
            switch response.result {
            case.success(let data):
                let json = JSON(data)
                
                let jsonArray = json["response"]["docs"].arrayValue
                var articles: [SearchArticle] = []
                for json in jsonArray {
                    articles.append(SearchArticle(json: json))
                }
                
                completion(articles)
                
            case.failure(let error):
                print(error)
            }
        }
    }
}
