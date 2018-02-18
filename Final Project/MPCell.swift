//
//  MPCell.swift
//  Final Project
//
//  Created by Theodore Carrel on 12/5/17.
//  Copyright © 2017 Theodore Carrel. All rights reserved.
//

import UIKit

class MPCell: UICollectionViewCell {
    
    //Custom cell that explains the current view controller
    var image: UIImageView!
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    
    let padding: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: 37.5, y: 25, width: 90, height: 90))
        image.image = #imageLiteral(resourceName: "even better")
        contentView.addSubview(image)
        
        titleLabel = UILabel(frame: CGRect(x: 37.5 + image.frame.size.width, y: 40, width: frame.width - (image.frame.size.width + 75), height: 30))
        titleLabel.text = "Most Popular"
        titleLabel.font = UIFont(name: "GillSans-Light", size: 25)
        contentView.addSubview(titleLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: image.frame.size.width + 37.5, y: 55, width: frame.width - (image.frame.size.width + 75), height:60))
        descriptionLabel.text = "Browse the most view articles from the past seven days, right here."
        descriptionLabel.numberOfLines = 2
        descriptionLabel.font = UIFont(name: "GillSans-Light", size: 15)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.textColor = #colorLiteral(red: 0.5788260102, green: 0.5854986906, blue: 0.6023046374, alpha: 1)
        contentView.addSubview(descriptionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
