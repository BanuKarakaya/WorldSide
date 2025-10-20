//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation

protocol SearchViewModelProtocol {
    func viewDidLoad()
    func newsAtIndex(index: Int) -> Datum?
}

protocol SearchViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareSearchBar()
    func reloadData()
}

final class SearchViewModel {
   private weak var delegate: SearchViewModelDelegate?
   private var news: [Datum]?
    private let networkManager: NetworkManagerInterface
    
    init(delegate: SearchViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchNews() {
        networkManager.getNews { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.news = responseData.data
                DispatchQueue.main.async {
                    self?.delegate?.reloadData()
                }
                print(responseData)
                break //break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func newsAtIndex(index: Int) -> Datum? {
        if let new = news?[index] {
            return new
        }
        return nil
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareSearchBar()
        fetchNews()
    }
}
