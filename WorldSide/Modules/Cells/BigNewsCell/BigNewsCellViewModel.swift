//
//  BigNewsCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 22.10.2025.
//

import Foundation
import CommonModule

protocol BigNewsCellViewModelProtocol {
    func load()
}

protocol BigNewsCellViewModelDelegate: AnyObject {
    func configureCell(news: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class BigNewsCellViewModel {
    private weak var delegate: BigNewsCellViewModelDelegate?
    private var news: Article?
    
    init(delegate: BigNewsCellViewModelDelegate?, news: Article?) {
        self.delegate = delegate
        self.news = news
    }
}

extension BigNewsCellViewModel: BigNewsCellViewModelProtocol {
    func load() {
        delegate?.setUI()
        if let news = news {
            delegate?.configureCell(news: news)
        }
    }
}
