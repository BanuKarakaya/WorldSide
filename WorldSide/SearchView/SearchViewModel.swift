//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation

protocol SearchViewModelProtocol {
    func viewDidLoad()
}

protocol SearchViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareSearchBar()
}

final class SearchViewModel {
   private weak var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareSearchBar()
    }
}
