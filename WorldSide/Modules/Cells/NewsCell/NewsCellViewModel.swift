//
//  NewsCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 12.10.2025.
//

import Foundation
import CommonModule

protocol NewsCellViewModelProtocol {
    func load()
}

protocol NewsCellViewModelDelegate: AnyObject {
    func configureCell(news: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class NewsCellViewModel {
    private weak var delegate: NewsCellViewModelDelegate?
    private var news: Article?
    
    init(delegate: NewsCellViewModelDelegate?, news: Article?) {
        self.delegate = delegate
        self.news = news
    }
}

extension NewsCellViewModel: NewsCellViewModelProtocol {
    func load() {
        delegate?.setUI()
        if let news = news {
            delegate?.configureCell(news: news)
        }
    }
}
