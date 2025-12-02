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
            viewModel.load()
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
        newsTitle.accessibilityIdentifier = "news_cell_title"
        newsSourceName.accessibilityIdentifier = "news_cell_source"
    }
    
    func configureCell(news: Article?) {
        prepareBannerImage(with: news?.urlToImage)
        newsTitle.text = news?.title
        newsSourceName.text = news?.source.name
        newsDate.text = news?.publishedAt
    }
}
