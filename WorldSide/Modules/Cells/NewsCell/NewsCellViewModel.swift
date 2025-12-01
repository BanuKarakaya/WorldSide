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
    func awakeFromNib()
}

protocol NewsCellViewModelDelegate: AnyObject {
    func configureCell(new: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class NewsCellViewModel {
    private weak var delegate: NewsCellViewModelDelegate?
    private var new: Article?
    
    init(delegate: NewsCellViewModelDelegate?, new: Article?) {
        self.delegate = delegate
        self.new = new
    }
}

extension NewsCellViewModel: NewsCellViewModelProtocol {
    func load() {
        if let new = new {
            delegate?.configureCell(new: new)
        }
    }
    
    func awakeFromNib() {
        delegate?.setUI()
    }
}
