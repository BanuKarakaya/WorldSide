//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation
import CommonModule
import NetworkLayer

protocol SearchViewModelProtocol {
    func viewDidLoad()
    func newsAtIndex(index: Int) -> Article?
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(searchText: String?)
    func didSelectItemAt(index: Int)
}

protocol SearchViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareSearchBar()
    func reloadData()
    func navigateToDetailVC(selectedCell: Article?)
}

final class SearchViewModel {
   private weak var delegate: SearchViewModelDelegate?
   private var news: [Article]?
   private var searchNews: [Article]?
   var isSearching = false
    private let networkManager: NetworkManagerInterface
    
    init(delegate: SearchViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchNews() {
        networkManager.getArticles { responseData in
            switch responseData {
            case .success(let responseData):
                self.news = responseData.articles
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func fetchSearchArticles(searchedText: String) {
            networkManager.getSearchArticles(completion: { responseData in
                switch responseData {
                case .success(let responseData):
                    self.searchNews = responseData.articles
                    DispatchQueue.main.async {
                        self.delegate?.reloadData()
                    }
                    print(responseData)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }, searchText: searchedText)
        }
}

extension SearchViewModel: SearchViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Article?
        
        if isSearching {
            selectedCell = searchNews?[index]
        } else {
            selectedCell = news?[index]
        }
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func searchBarCancelButtonClicked() {
        isSearching = false
        delegate?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchText: String?) {
        if let searchText = searchText {
            isSearching = true
            fetchSearchArticles(searchedText: searchText)
            delegate?.reloadData()
        }
    }
    
    func newsAtIndex(index: Int) -> Article? {
        if isSearching {
            if let new = searchNews?[index] {
                return new
            }
        } else {
            if let new = news?[index] {
                return new
            }
        }
        return nil
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareSearchBar()
        fetchNews()
    }
}
