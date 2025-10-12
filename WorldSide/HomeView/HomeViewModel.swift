//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
}

final class HomeViewModel {
   private weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
    }
}
