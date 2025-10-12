//
//  HorizontalForYouCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation

protocol HorizontalForYouCellViewModelProtocol {
    func awakeFromNib()
}

protocol HorizontalForYouCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
}

final class HorizontalForYouCellViewModel {
    private weak var delegate: HorizontalForYouCellViewModelDelegate?
    
    init(delegate: HorizontalForYouCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HorizontalForYouCellViewModel: HorizontalForYouCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareCollectionView()
    }
}
