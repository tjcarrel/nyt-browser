//
//  SearchCell.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/3/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    var titleLabel: UILabel!
    var thumbnail: UIImageView!
    var dateLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        titleLabel = UILabel(frame: CGRect(x: 5, y: 5, width: frame.size.width - 20, height: frame.size.height*2 - 10))
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Baskerville-Bold", size: 20)
        contentView.addSubview(titleLabel)
        
//        dateLabel = UILabel(frame: CGRect(x: 7, y: frame.size.height*2 - 8, width: 100, height: 20))
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "STHeitiSC-Medium", size: 10)
        dateLabel.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        contentView.addSubview(dateLabel)
        
//        thumbnail = UIImageView(frame: CGRect(x: frame.size.width - 20, y: 15, width: 75, height: 75))
        thumbnail = UIImageView()
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(thumbnail)
        
        //Function that sets up layout
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Sets constraints for various elements
    func setupLayout() {
    
        //For date label
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.frame.width*0.05).isActive = true
        
        //For thumbnail
        thumbnail.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height*0.3).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 75).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        //For title label
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height*0.15).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: contentView.frame.width*0.05).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: thumbnail.leftAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height*1.5).isActive = true
        titleLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    //Sets up the detailed view controller with appropriate items
    func setupWithArticle(article: SearchArticle) {
        
        titleLabel.text = article.headline
        dateLabel.text = article.date
        
        if (article.thumbnail == nil) {
            
            thumbnail.image = UIImage(named: "NYT Logo")
            
        } else {
            
        thumbnail.image = article.thumbnail
            
        }
    }

    
}
