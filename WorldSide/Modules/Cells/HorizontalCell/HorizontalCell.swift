//
//  HorizontalCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit

final class HorizontalCell: UICollectionViewCell {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    
    var viewModel: HorizontalCellViewModelProtocol! {
        didSet {
            viewModel.load()
        }
    }
}

extension HorizontalCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

extension HorizontalCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: BigNewsCell.self, indexPath: indexPath)
        let news = viewModel.newsAtIndex(index: indexPath.item)
        let cellViewModel = BigNewsCellViewModel(delegate: cell, news: news)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension HorizontalCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 300, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HorizontalCell: HorizontalCellViewModelDelegate {
    func setAccessabilityLabel() {
        accessibilityIdentifier = "MyFirstSection"
    }
    
    func reloadData() {
        horizontalCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        horizontalCollectionView.delegate = self
        horizontalCollectionView.showsHorizontalScrollIndicator = false
        horizontalCollectionView.dataSource = self
        horizontalCollectionView.register(cellType: BigNewsCell.self)
    }
}
