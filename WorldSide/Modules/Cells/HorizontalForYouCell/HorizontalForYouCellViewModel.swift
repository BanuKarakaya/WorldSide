//
//  HorizontalForYouCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation
import CommonModule

protocol HorizontalForYouCellViewModelProtocol {
    var numberOfItems: Int { get }
    func load()
    func configureCell(horizontalNews: [Article])
    func newsAtIndex(index: Int) -> Article?
    func didSelectItemAt(indexPath: IndexPath)
}

protocol HorizontalForYouCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func setAccessabilityLabel()
}

protocol HorizontalForYouCellViewModelNavigationDelegate: AnyObject {
    func didSelectItemAtForYouCell(indexPath: IndexPath)
}

final class HorizontalForYouCellViewModel {
    private weak var delegate: HorizontalForYouCellViewModelDelegate?
    private weak var navigationDelegate: HorizontalForYouCellViewModelNavigationDelegate?
    private var forYouNews: [Article]?
    
    init(delegate: HorizontalForYouCellViewModelDelegate?,navigationDelegate: HorizontalForYouCellViewModelNavigationDelegate?) {
        self.delegate = delegate
        self.navigationDelegate = navigationDelegate
    }
}

extension HorizontalForYouCellViewModel: HorizontalForYouCellViewModelProtocol {
    var numberOfItems: Int {
        10
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        navigationDelegate?.didSelectItemAtForYouCell(indexPath: indexPath)
    }
    
    func newsAtIndex(index: Int) -> Article? {
        if let news = forYouNews?[index] {
            return news
        }
        return nil
    }
    
    func configureCell(horizontalNews: [Article]) {
        self.forYouNews = horizontalNews
        delegate?.reloadData()
    }
    
    func load() {
        delegate?.prepareCollectionView()
        delegate?.setAccessabilityLabel()
    }
}
