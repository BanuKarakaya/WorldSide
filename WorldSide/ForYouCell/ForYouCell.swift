//
//  ForYouCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit

final class ForYouCell: UICollectionViewCell {

    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var publishedTime: UILabel!
    
    
    var viewModel: ForYouCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension ForYouCell: ForYouCellViewModelDelegate {
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newImage.sd_setImage(with: url)
        }
    }
    
    func setUI() {
        self.layer.cornerRadius = 10
        newImage.layer.cornerRadius = 10
    }
    
    func configureCell(new: Article?) {
        prepareBannerImage(with: new?.urlToImage)
        newTitle.text = new?.title
        sourceName.text = new?.source.name
        publishedTime.text = new?.publishedAt
    }
}
