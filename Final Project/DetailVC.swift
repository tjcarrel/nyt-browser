//
//  DetailVC.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/8/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit
import SafariServices

class DetailVC: UIViewController {

    var titleLabel : UILabel!
    var articleImage: UIImageView!
    var sectionLabel: UILabel!
    var dateLabel: UILabel!
    var snippetLabel: UILabel!
    var gotoButton: UIButton!
    
    var titleText: String!
    var image: UIImage!
    var sectionText: String!
    var dateText: String!
    var snippetText: String!
    var url: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newWidth: CGFloat = view.frame.size.width*0.8

        view.backgroundColor = .white
        
        //Article image
        if(image == nil) {image = UIImage(named: "NYT Logo")}
        articleImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newWidth, height: view.frame.size.height/3))
        articleImage.image = image
        view.addSubview(articleImage)
        
        var height: CGFloat = articleImage.frame.size.height
        
        //Article title label
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = titleText
        titleLabel.numberOfLines = 3
        view.addSubview(titleLabel)

        //Article section label
        sectionLabel = UILabel()
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        sectionLabel.text = sectionText
        sectionLabel.textAlignment = .center
        sectionLabel.font = UIFont(name: "AvenirNext-Regular", size: 11)
        sectionLabel.sizeToFit()
        sectionLabel.center = CGPoint(x: newWidth/2, y: sectionLabel.frame.midY)
        sectionLabel.textColor = #colorLiteral(red: 0.4160223603, green: 0.4160968959, blue: 0.4160125852, alpha: 1)
        view.addSubview(sectionLabel)
        
        //Article date label
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = dateText
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "AvenirNext-Regular", size: 10)
        dateLabel.sizeToFit()
        dateLabel.center = CGPoint(x: newWidth/2, y: dateLabel.frame.midY)
        dateLabel.textColor = #colorLiteral(red: 0.4160223603, green: 0.4160968959, blue: 0.4160125852, alpha: 1)
        view.addSubview(dateLabel)

        //Button that opens up webpage of article
        gotoButton = UIButton()
        gotoButton.translatesAutoresizingMaskIntoConstraints = false
        gotoButton.setTitle("Go To Article", for: .normal)
        gotoButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        gotoButton.backgroundColor = #colorLiteral(red: 0, green: 0.5008062124, blue: 1, alpha: 1)
        gotoButton.addTarget(self, action: #selector(openArticle), for: .touchUpInside)
        gotoButton.layer.cornerRadius = 8.0
        view.addSubview(gotoButton)
        
        //Label for description of article
        snippetLabel = UILabel()
        snippetLabel.translatesAutoresizingMaskIntoConstraints = false
        snippetLabel.text = snippetText
        snippetLabel.numberOfLines = 0
        view.addSubview(snippetLabel)
        
        //Function that sets constraints for elements
        setupLayout()
        
    }
    
    //Sets attributes and constraints for various elements
    func setupLayout() {
        
        //For title label
        titleLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.01).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: view.frame.height*0.1).isActive = true
        titleLabel.font = UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: 22)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        
        //For section label
        sectionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        sectionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.01).isActive = true
        
        //For date label
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width*0.01).isActive = true
        
        //For webpage button
        gotoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.width*0.015).isActive = true
        gotoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.015).isActive = true
        gotoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width*0.015).isActive = true
        gotoButton.heightAnchor.constraint(equalToConstant: view.frame.height*0.055).isActive = true
        
        //For snippet label
        snippetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        snippetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width*0.015).isActive = true
        snippetLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -view.frame.width*0.015).isActive = true
        snippetLabel.bottomAnchor.constraint(equalTo: gotoButton.topAnchor, constant: -10).isActive = true
        snippetLabel.font = UIFont(name: "OriyaSangamMN", size: 18)
        snippetLabel.textAlignment = .center
        snippetLabel.adjustsFontSizeToFitWidth = true
        
    }

    //Opens up web page of the article
    @objc func openArticle() {

        let svc = SFSafariViewController(url: URL(string: url)!)
        svc.modalPresentationStyle = .overFullScreen
        present(svc, animated: true, completion: nil)
        
    }
    
}
