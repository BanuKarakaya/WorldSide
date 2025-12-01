//
//  NewsCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 8.10.2025.
//

import UIKit
import SDWebImage
import CommonModule

final class NewsCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSourceImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    var viewModel: NewsCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
            newsTitle.accessibilityIdentifier = "news_cell_title"
            newsSourceName.accessibilityIdentifier = "news_cell_source"
        }
    }
}

extension NewsCell: NewsCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newsImage.sd_setImage(with: url)
        }
    }
    
    func setUI() {
        newsImage.layer.cornerRadius = 10
    }
    
    func configureCell(new: Article?) {
        prepareBannerImage(with: new?.urlToImage)
        newsTitle.text = new?.title
        newsSourceName.text = new?.source.name
        newsDate.text = new?.publishedAt
    }
}
