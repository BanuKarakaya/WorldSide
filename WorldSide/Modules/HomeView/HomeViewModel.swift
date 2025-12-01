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
    
    func viewDidLoad()
    func newsAtIndex(index: Int) -> Article?
    func didSelectItemAt(index: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
    func navigateToDetailVC(selectedCell: Article?)
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

    func fetchCategoriesArticles(categoriesWord: String) {
            networkManager.getCategoriesArticles(completion: { responseData in
                switch responseData {
                case .success(let responseData):
                    self.forYouNewss = responseData.articles
                    DispatchQueue.main.async {
                        self.delegate?.reloadData()
                    }
                    print(responseData)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }, categoriesWord: categoriesWord)
        }
    
    func fetchSearchArticles(searchedText: String) {
            networkManager.getSearchArticles(completion: { responseData in
                switch responseData {
                case .success(let responseData):
                    self.horizontalNewss = responseData.articles
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

extension HomeViewModel: HomeViewModelProtocol {
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
        if let new = news?[index] {
            return new
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
        
        group.notify(queue: .main) { [self] in
            print("All processes finished")
            fetchSearchArticles(searchedText: "Trump")
            fetchCategoriesArticles(categoriesWord: "Entertainment")
            fetchNews()
            
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
