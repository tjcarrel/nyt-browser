//
//  ArticleCell.swift
//  Final Project
//
//  Created by Theodore Carrel on 11/29/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var authorLabel: UILabel!
    var dateLabel: UILabel!
    var sectionLabel: UILabel!
    var imageView: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let iheight = frame.size.height*0.8
        
        //Article's image
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width , height: iheight))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        
        //Sectiona artcle belongs to
        sectionLabel = UILabel(frame: CGRect(x: 15, y: iheight, width: 150, height: 38))
        sectionLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 12)
        contentView.addSubview(sectionLabel)
        
        //Title of art
        titleLabel = UILabel(frame: CGRect(x: 15, y: iheight + sectionLabel.frame.size.height - 10, width: frame.size.width - 30, height: frame.size.height - iheight - sectionLabel.frame.size.height))
        titleLabel.font = UIFont(name: "AvenirNext-Bold", size: 20)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byClipping
        contentView.addSubview(titleLabel)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        layoutIfNeeded()

    }
    
    // Configure cell
    func handle(article: Article) {
        
        titleLabel.text = article.title
        sectionLabel.text = article.section

        if let link = article.imageLink {
            if let url = URL(string: link) {
                if let data = try? Data(contentsOf: url) {
                    imageView.image = UIImage(data: data)
                        }
                    }
                }
            }
    
}

