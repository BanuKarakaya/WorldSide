//
//  HorizontalCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation

protocol HorizontalCellViewModelProtocol {
    func awakeFromNib()
    func configureCell(horizontalNews: [Datum])
    func newsAtIndex(index: Int) -> Datum?
}

protocol HorizontalCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
   func reloadData()
}

final class HorizontalCellViewModel {
    private weak var delegate: HorizontalCellViewModelDelegate?
    private var horizontalNews: [Datum]?
    
    init(delegate: HorizontalCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HorizontalCellViewModel: HorizontalCellViewModelProtocol {
    func newsAtIndex(index: Int) -> Datum? {
        if let new = horizontalNews?[index] {
            return new
        }
        return nil
    }
    
    func configureCell(horizontalNews: [Datum]) {
        self.horizontalNews = horizontalNews
        delegate?.reloadData()
    }
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
    }
}
