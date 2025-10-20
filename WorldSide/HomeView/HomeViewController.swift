//
//  HomeViewController.swift
//  WorldSide
//
//  Created by Banu Karakaya on 7.10.2025.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    let color = UIColor(red: 0xE3/255.0, green: 0x51/255.0, blue: 0x3B/255.0, alpha: 1.0)

    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 9
        default:
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeCell(cellType: HorizontalCell.self, indexPath: indexPath)
            let cellViewModel = HorizontalCellViewModel(delegate: cell)
            cellViewModel.configureCell(horizontalNews: viewModel.horizontalNews)
            return cell
        } else if  indexPath.section == 1 {
            let cell = collectionView.dequeCell(cellType: HorizontalForYouCell.self, indexPath: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeCell(cellType: NewsCell.self, indexPath: indexPath)
            return cell
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 5, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        case 1:
            return 0
        case 2:
            return 0
        default:
            return 0
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func reloadData() {
        newsCollectionView.reloadData()
    }
    
    func prepareUI() {
        self.title = "News"
        let textAttributes = [NSAttributedString.Key.foregroundColor: color]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        newsCollectionView.showsVerticalScrollIndicator = false
    }
    
    func prepareCollectionView() {
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        newsCollectionView.register(cellType: HorizontalForYouCell.self)
        newsCollectionView.register(cellType: HorizontalCell.self)
        newsCollectionView.register(cellType: NewsCell.self)
    }
}
