//
//  HorizontalCellViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import Foundation
import CommonModule

protocol HorizontalCellViewModelProtocol {
    var numberOfItems: Int { get }
    func load()
    func configureCell(horizontalNews: [Article])
    func newsAtIndex(index: Int) -> Article?
    func didSelectItemAt(indexPath: IndexPath)
}

protocol HorizontalCellViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func setAccessabilityLabel()
}

protocol HorizontalCellViewModelNavigationDelegate: AnyObject {
    func didSelectItemAt(indexPath: IndexPath)
}

final class HorizontalCellViewModel {
    private weak var delegate: HorizontalCellViewModelDelegate?
    private weak var navigationDelegate: HorizontalCellViewModelNavigationDelegate?
    private var horizontalNews: [Article]?
    
    init(delegate: HorizontalCellViewModelDelegate?,
         navigationDelegate: HorizontalCellViewModelNavigationDelegate?) {
        self.delegate = delegate
        self.navigationDelegate = navigationDelegate
    }
}

extension HorizontalCellViewModel: HorizontalCellViewModelProtocol {
    var numberOfItems: Int {
        return 10
    }
    
    func newsAtIndex(index: Int) -> Article? {
        if let news = horizontalNews?[index] {
            return news
        }
        return nil
    }
    
    func configureCell(horizontalNews: [Article]) {
        self.horizontalNews = horizontalNews
        delegate?.reloadData()
    }
    
    func load() {
        delegate?.prepareCollectionView()
        delegate?.setAccessabilityLabel()
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        navigationDelegate?.didSelectItemAt(indexPath: indexPath)
    }
}

