//
//  HorizontalCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation

protocol HorizontalCellViewModelProtocol {
    func awakeFromNib()
    func configureCell(horizontalNews: [Article])
    func newsAtIndex(index: Int) -> Article?
}

protocol HorizontalCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
   func reloadData()
   func setAccessabilityLabel()
}

final class HorizontalCellViewModel {
    private weak var delegate: HorizontalCellViewModelDelegate?
    private var horizontalNews: [Article]?
    
    init(delegate: HorizontalCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HorizontalCellViewModel: HorizontalCellViewModelProtocol {
    func newsAtIndex(index: Int) -> Article? {
        if let new = horizontalNews?[index] {
            return new
        }
        return nil
    }
    
    func configureCell(horizontalNews: [Article]) {
        self.horizontalNews = horizontalNews
        delegate?.reloadData()
    }
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
        delegate?.setAccessabilityLabel()
    }
}
