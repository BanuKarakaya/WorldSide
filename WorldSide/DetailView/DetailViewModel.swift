//
//  DetailViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 23.10.2025.
//

import Foundation

protocol DetailViewModelProtocol {
    func viewDidLoad()
}

protocol DetailViewModelDelegate: AnyObject {
    func configure(selectedNew: Article?)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
}

final class DetailViewModel {
    private weak var delegate: DetailViewModelDelegate?
    var selectedNew: Article?
    
    init(delegate: DetailViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.configure(selectedNew: selectedNew!)
    }
}
