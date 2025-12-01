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
    func awakeFromNib()
}

protocol ForYouCellViewModelDelegate: AnyObject {
    func configureCell(new: Article?)
    func setUI()
    func prepareBannerImage(with urlString: String?)
}

final class ForYouCellViewModel {
    private weak var delegate: ForYouCellViewModelDelegate?
    private var new: Article?
    
    init(delegate: ForYouCellViewModelDelegate?, new: Article?) {
        self.delegate = delegate
        self.new = new
    }
}

extension ForYouCellViewModel: ForYouCellViewModelProtocol {
    func load() {
        if let new = new {
            delegate?.configureCell(new: new)
        }
    }
    
    func awakeFromNib() {
        delegate?.setUI()
    }
}
