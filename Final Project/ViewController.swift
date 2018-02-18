//
//  ViewController.swift
//  Final Project
//
//  Created by Theodore Carrel on 11/29/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import Presentr
import SafariServices
import TransitionButton


class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var emptyLabel: UILabel!
    var searchButton: TransitionButton!
    
    let interItemSpacing: CGFloat = 10.0
    let lineSpacing: CGFloat = 10.0
    let constant: CGFloat = 50
    
    var articles: [Article] = []
    
    var url: String!
    
    //Create custom Presentr popup
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

        //Set title image to NYT logo and set up navigation bar
        let titleImage = #imageLiteral(resourceName: "nytimes logo")
        self.navigationItem.titleView = UIImageView(image: titleImage)
        
        view.backgroundColor = .white
        
        //Navigation bar attributes
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
        
        //Function for collectionview
        setupCollectionView()
        
        //Pulls articles from API
        getPosts()
    }
    
    
    
    func setupCollectionView() {
        
        // Create and customize collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = collectionViewCellSpacing
        layout.sectionInset.top = collectionViewCellMargin
        layout.sectionInset.bottom = collectionViewCellMargin * 2
        
        //Create collection view
        collectionView = UICollectionView(frame: CGRect(x: view.frame.minX, y: 0, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9348208308, green: 0.9401834011, blue: 0.9534268975, alpha: 1)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.register(MPCell.self, forCellWithReuseIdentifier: "MPCell")
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        
        // Create pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getPosts), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        // Create empty label
        emptyLabel = UILabel()
        emptyLabel.font = UIFont(name: "Avenir-Medium", size: 24.0)
        emptyLabel.textColor = .lightGray
        emptyLabel.text = "Writers? Editors? Anyone here..."
        emptyLabel.sizeToFit()
        emptyLabel.center = CGPoint(x: view.center.x, y: view.center.y)
        view.addSubview(emptyLabel)
        
        //For search button
        searchButton = TransitionButton()
        collectionView.addSubview(searchButton)
        setupButton()
        
        
    }
    
    //Function that sets attributes and constraints for search button
    func setupButton() {
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchButton.setImage(#imageLiteral(resourceName: "Search icon"), for: .normal)
        searchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        searchButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.layer.cornerRadius = 25
        searchButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        searchButton.layer.borderWidth = 2.0
        searchButton.clipsToBounds = true
        searchButton.addTarget(self, action: #selector(searchClicked), for: .touchUpInside)
        
    }
    
    //Presents search view controller
    @objc func searchClicked() {
        
        searchButton.startAnimation()
        searchButton.stopAnimation(animationStyle: .expand, completion: {
            let secondvc = SearchViewController()
            self.present(secondvc, animated: true, completion: nil)
        })
    
    }
    
    //Brings articles to view controller and updates the collectionview
    @objc func getPosts() {
        
        NetworkManager.getPosts { articles in
            
            self.articles = articles
            self.updateCollectionView()
            
        }
    }
    
    //Reloads collectionview
    func updateCollectionView() {
        
        collectionView.reloadSections(IndexSet(integer: 0))
        emptyLabel.isHidden = !articles.isEmpty
        collectionView.refreshControl?.endRefreshing()
        
    }
    
    //Sets up detail view controller with appropriate info when card is tapped
    func presentDestinationVC(article: Article) {
        
        let vc = DetailVC()
        vc.image = article.image
        vc.titleText = article.title
        vc.url = article.url
        vc.dateText = article.date
        vc.sectionText = article.section
        vc.snippetText = article.abstract

        customPresentViewController(presenter, viewController: vc, animated: true, completion: nil)
    
    }
    
    
    //COLLECTIONVIEW FUNCTIONS
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //First card explains the view controller
        if(indexPath.item == 0) {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MPCell", for: indexPath) as! MPCell
            
            return cell
            
        } else {
            
            //Rest are actually articles
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! ArticleCell
            let article = articles[indexPath.item - 1]
            cell.handle(article: article)
            cell.layer.cornerRadius = 8.0
            cell.backgroundColor = .white
            cell.layoutIfNeeded()
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        var cellsize = CGSize(width: view.frame.width*0.85, height: view.frame.height*0.6)
       
        if(indexPath.item == 0) {
            cellsize.height = view.frame.height*0.15
            cellsize.width = view.frame.width
        }

        return cellsize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: -20, left: -20.0, bottom: lineSpacing, right: -20.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 25
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(indexPath.item != 0) {
            
            let article = articles[indexPath.row-1]
            presentDestinationVC(article: article)
            
            }
        }
    
}

