//
//  HorizontalForYouCell.swift
//  WorldSide
//
//  Created by Banu Karakaya on 9.10.2025.
//

import UIKit
import CommonModule

final class HorizontalForYouCell: UICollectionViewCell {

    @IBOutlet weak var horizontalForYouCollectionView: UICollectionView!
    
    var viewModel: HorizontalForYouCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
        }
    }
}

extension HorizontalForYouCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

extension HorizontalForYouCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: ForYouCell.self, indexPath: indexPath)
        let new = viewModel.newsAtIndex(index: indexPath.item)
        let cellViewModel = ForYouCellViewModel(delegate: cell, new: new)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension HorizontalForYouCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 200, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 0, right: 10)
    }
}

extension HorizontalForYouCell: HorizontalForYouCellViewModelDelegate {
    func navigateToDetailVC(selectedCell: Article?) {
       
    }
    
    func setAccessabilityLabel() {
        accessibilityIdentifier = "MySecondSection"
    }
    
    func prepareCollectionView() {
        horizontalForYouCollectionView.delegate = self
        horizontalForYouCollectionView.dataSource = self
        horizontalForYouCollectionView.showsHorizontalScrollIndicator = false
        horizontalForYouCollectionView.register(cellType: ForYouCell.self)
    }
}
