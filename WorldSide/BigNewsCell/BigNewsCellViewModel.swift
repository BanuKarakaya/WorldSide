//
//  BigNewsCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 22.10.2025.
//

import Foundation

protocol BigNewsCellViewModelProtocol {
    func load()
    func awakeFromNib()
}

protocol BigNewsCellViewModelDelegate: AnyObject {
    func configureCell(new: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class BigNewsCellViewModel {
    private weak var delegate: BigNewsCellViewModelDelegate?
    private var new: Article?
    
    init(delegate: BigNewsCellViewModelDelegate?, new: Article?) {
        self.delegate = delegate
        self.new = new
    }
}

extension BigNewsCellViewModel: BigNewsCellViewModelProtocol {
    func load() {
        if let new = new {
            delegate?.configureCell(new: new)
        }
    }
    
    func awakeFromNib() {
        delegate?.setUI()
    }
}
