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
    var numberOfItems: Int { get }
    
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
    func prepareUI()
    func navigateToDetailVC(selectedCell: Article?)
    func showAlert(title: String?, message: String?)
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
        networkManager.getArticles { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.news = responseData.articles
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showAlert(title: error.title, message: error.message)
            }
        }
    }
    
    func fetchSearchArticles(searchedText: String) {
        networkManager.getSearchArticles(completion: { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.searchNews = responseData.articles
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showAlert(title: error.title, message: error.message)
            }
        }, searchText: searchedText)
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    var numberOfItems: Int {
        return (isSearching ? searchNews?.count : news?.count)  ?? .zero
    }
    
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
            if let news = searchNews?[index] {
                return news
            }
        } else {
            if let news = news?[index] {
                return news
            }
        }
        return nil
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.prepareCollectionView()
        delegate?.prepareSearchBar()
        fetchNews()
    }
}
