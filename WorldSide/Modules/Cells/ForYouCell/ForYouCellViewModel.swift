//
//  ForYouCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 24.10.2025.
//

import Foundation
import CommonModule

protocol ForYouCellViewModelProtocol {
    func load()
}

protocol ForYouCellViewModelDelegate: AnyObject {
    func configureCell(news: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class ForYouCellViewModel {
    private weak var delegate: ForYouCellViewModelDelegate?
    private var news: Article?
    
    init(delegate: ForYouCellViewModelDelegate?, news: Article?) {
        self.delegate = delegate
        self.news = news
    }
}

extension ForYouCellViewModel: ForYouCellViewModelProtocol {
    func load() {
        delegate?.setUI()
        if let news = news {
            delegate?.configureCell(news: news)
        }
    }
}
