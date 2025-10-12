//
//  ForYouCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit

final class ForYouCell: UICollectionViewCell {

    @IBOutlet weak var newImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        newImage.layer.cornerRadius = 10
    }
}
