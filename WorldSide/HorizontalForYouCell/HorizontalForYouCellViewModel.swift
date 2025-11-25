//
//  HorizontalForYouCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation

protocol HorizontalForYouCellViewModelProtocol {
    func awakeFromNib()
    func configureCell(horizontalNews: [Article])
    func newsAtIndex(index: Int) -> Article?
    func didSelectItemAt(index: Int)
}

protocol HorizontalForYouCellViewModelDelegate: AnyObject {
   func prepareCollectionView()
   func setAccessabilityLabel()
   func navigateToDetailVC(selectedCell: Article?)
}

final class HorizontalForYouCellViewModel {
    private weak var delegate: HorizontalForYouCellViewModelDelegate?
    private var forYouNews: [Article]?
    
    init(delegate: HorizontalForYouCellViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HorizontalForYouCellViewModel: HorizontalForYouCellViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Article?
                
        selectedCell = forYouNews?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func newsAtIndex(index: Int) -> Article? {
        if let new = forYouNews?[index] {
            return new
        }
        return nil
    }
    
    func configureCell(horizontalNews: [Article]) {
        self.forYouNews = horizontalNews
    }
    
    func awakeFromNib() {
        delegate?.prepareCollectionView()
        delegate?.setAccessabilityLabel()
    }
}
