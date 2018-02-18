//
//  SearchViewController.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/3/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Presentr
import TransitionButton

class subclassedUIButton: UIButton {
    var urlString: String?
}

class SearchViewController: CustomTransitionViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var searchLabel: UILabel!
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var popularButton: TransitionButton!

    var isSearching = false
    var center: CGPoint!
    var frame: CGRect!
    
    var articles: [SearchArticle] = []
    
    let interItemSpacing: CGFloat = 10.0
    let lineSpacing: CGFloat = 10.0
    
    let presenter: Presentr = {
        
        let width = ModalSize.fluid(percentage: 0.80)
        let height = ModalSize.fluid(percentage: 0.75)
        let center = ModalCenterPosition.center
        let customType = PresentationType.custom(width: width, height: height, center: center)
        
        let customPresenter = Presentr(presentationType: customType)
        customPresenter.backgroundOpacity = 0.75
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnTap = true
        customPresenter.backgroundColor = .black
        customPresenter.roundCorners = true
        customPresenter.cornerRadius = 10
        
        return customPresenter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .white
        
        //Creates search label
        searchLabel = UILabel()
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchLabel)
        
        //Creates searchbar
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        view.addSubview(searchBar)
        
        //Creates button to go back to popular articles
        popularButton = TransitionButton()
        popularButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popularButton)
        
        //Function to set up layout
        setupLayouts()
    }
    
    //Sets attributes and constraints for various elements
    func setupLayouts() {
        
        //For search label
        searchLabel.text = "SEARCH"
        searchLabel.font = UIFont(name: "GillSans-Bold", size: 30)
        searchLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
        searchLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        //For search bar
        searchBar.placeholder = "Search Article Title"
        searchBar.backgroundColor = .white
        searchBar.barTintColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 10
        center = searchBar.center
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        searchBar.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 5).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.width-20).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //For button
        popularButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        popularButton.setImage(#imageLiteral(resourceName: "even better"), for: .normal)
        popularButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        popularButton.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -5).isActive = true
        popularButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        popularButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        popularButton.addTarget(self, action: #selector(popularTouched), for: .touchUpInside)
        
    }
    
    //Goes back to previous view controller
    @objc func popularTouched() {
        
       dismiss(animated: true, completion: nil)
        
    }
    
    //Sets up the table view that displays search results
    func setupTableView() {
        
        if tableView == nil {
            tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(SearchCell.self, forCellReuseIdentifier: "TableViewCell")
            frame = tableView.frame
            view.addSubview(tableView)
            
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        }

    }
    
    //SEARCH BAR FUNCTIONS
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        view.addSubview(searchLabel)
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
        self.articles = []
        self.tableView.removeFromSuperview()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        let text = searchBar.text
        
        NetworkManager.getSearch(text: text!, completion: {articles in
            self.articles = articles
            self.tableView.reloadData()
        })
        
        setupTableView()
        
    }
    
    func presentDestinationVC(article: SearchArticle) {
        
        let vc = DetailVC()
        vc.image = article.largeImage
        vc.titleText = article.headline
        vc.url = article.url
        vc.dateText = article.date
        vc.sectionText = article.section
        vc.snippetText = article.snippet
        
        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    }
    
    //FUNCTIONS FOR TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! SearchCell
        let article = articles[indexPath.row]
        cell.setupWithArticle(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = articles[indexPath.row]
        presentDestinationVC(article: article)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
