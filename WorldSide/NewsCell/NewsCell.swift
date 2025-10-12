//
//  NewsCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 8.10.2025.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 10
    }
}
