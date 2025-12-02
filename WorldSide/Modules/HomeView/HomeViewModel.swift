//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation
import CommonModule
import NetworkLayer

protocol HomeViewModelProtocol {
    var navigationDelegate: HorizontalCellViewModelNavigationDelegate { get }
    var navigationForYouDelegate: HorizontalForYouCellViewModelNavigationDelegate { get }
    var horizontalNews: [Article]? { get }
    var forYouNews: [Article]? { get }
    var numberOfSections: Int { get }
    
    func viewDidLoad()
    func newsAtIndex(index: Int) -> Article?
    func didSelectItemAt(index: Int)
    func numberOfItems(section: Int) -> Int
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
    func navigateToDetailVC(selectedCell: Article?)
    func showAlert(title: String?, message: String?)
}

final class HomeViewModel {
    private weak var delegate: HomeViewModelDelegate?
    private let networkManager: NetworkManagerInterface
    var news: [Article]?
    var horizontalNewss: [Article]?
    var forYouNewss: [Article]?
    let group = DispatchGroup()
    
    init(delegate: HomeViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchNews() {
        networkManager.getArticles { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.news = responseData.articles
                DispatchQueue.main.async {
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                self?.delegate?.showAlert(title: error.title, message: error.message)
            }
        }
    }
    
    func fetchCategoriesArticles(categoriesWord: String) {
        networkManager.getCategoriesArticles(completion: { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.forYouNewss = responseData.articles
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showAlert(title: error.title, message: error.message)
            }
        }, categoriesWord: categoriesWord)
    }
    
    func fetchSportsArticles(categoriesWord: String) {
        networkManager.getCategoriesArticles(completion: { [weak self] responseData in
            switch responseData {
            case .success(let responseData):
                self?.horizontalNewss = responseData.articles
                self?.delegate?.reloadData()
            case .failure(let error):
                self?.delegate?.showAlert(title: error.title, message: error.message)
            }
        }, categoriesWord: categoriesWord)
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func numberOfItems(section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 10
        } else {
            return 0
        }
    }
    
    var numberOfSections: Int {
        3
    }
    
    var navigationForYouDelegate: HorizontalForYouCellViewModelNavigationDelegate {
        self
    }
    
    var navigationDelegate: HorizontalCellViewModelNavigationDelegate {
        self
    }
    
    func didSelectItemAt(index: Int) {
        var selectedCell: Article?
        
        selectedCell = news?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func newsAtIndex(index: Int) -> Article? {
        if let news = news?[index] {
            return news
        }
        return nil
    }
    
    var forYouNews: [Article]? {
        forYouNewss
    }
    
    var horizontalNews: [Article]? {
        horizontalNewss
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        
        group.notify(queue: .main) { [weak self] in
            self?.fetchSportsArticles(categoriesWord: "Sports")
            self?.fetchCategoriesArticles(categoriesWord: "Entertainment")
            self?.fetchNews()
        }
    }
}

extension HomeViewModel: HorizontalCellViewModelNavigationDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        var selectedCell: Article?
        
        selectedCell = horizontalNewss?[indexPath.item]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
}

extension HomeViewModel: HorizontalForYouCellViewModelNavigationDelegate {
    func didSelectItemAtForYouCell(indexPath: IndexPath) {
        var selectedCell: Article?
        
        selectedCell = forYouNewss?[indexPath.item]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
}
