//
//  HomeViewModel.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
    var horizontalNews: [Datum]? { get }
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func prepareUI()
    func reloadData()
}

final class HomeViewModel {
   private weak var delegate: HomeViewModelDelegate?
    private let networkManager: NetworkManagerInterface
    var news: [Datum]?
    var cnnNews: [Datum]?
    let group = DispatchGroup()
    
    init(delegate: HomeViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
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
    
    func fetchCnnNews() {
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

extension HomeViewModel: HomeViewModelProtocol {
    var horizontalNews: [Datum]? {
        cnnNews
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        
        group.notify(queue: .main) { [self] in
            print("All processes finished")
            fetchNews()
            fetchCnnNews()
        }
    }
}
