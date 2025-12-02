//
//  BigNewsCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 8.10.2025.
//

import UIKit
import CommonModule

final class BigNewsCell: UICollectionViewCell {
    
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    
    var viewModel: BigNewsCellViewModelProtocol! {
        didSet {
            viewModel.load()
        }
    }
}

extension BigNewsCell: BigNewsCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newImage.sd_setImage(with: url)
        }
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
    }
    
    func configureCell(news: Article?) {
        prepareBannerImage(with: news?.urlToImage)
        newTitle.text = news?.title
    }
}
