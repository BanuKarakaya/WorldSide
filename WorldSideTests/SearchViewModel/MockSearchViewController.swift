//
//  MockSearchViewController.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

@testable import WorldSide

final class MockSearchViewController: SearchViewModelDelegate {
   
    var invokedPrepareCollectionView = false
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
    }
    
    var invokedPrepareSearchBar = false
    func prepareSearchBar() {
        invokedPrepareSearchBar = true
    }
    
    var invokedReloadData = false
    func reloadData() {
        invokedReloadData = true
    }
    
    var invokedNavigateToDetailVC = false
    var selectedCellValue: WorldSide.Article?
    func navigateToDetailVC(selectedCell: WorldSide.Article?) {
        invokedNavigateToDetailVC = true
        selectedCellValue = selectedCell
    }
}
