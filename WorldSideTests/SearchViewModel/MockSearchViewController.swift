//
//  MockSearchViewController.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

@testable import WorldSide
import CommonModule

final class MockSearchViewController: SearchViewModelDelegate {
    
    var invokedshowAlert = false
    var showAlertTitle: String?
    var showAlertmessage: String?
    func showAlert(title: String?, message: String?) {
        invokedshowAlert = true
        showAlertTitle = title
        showAlertmessage = message
    }
    
    var invokedPrepareUI = false
    func prepareUI() {
        invokedPrepareUI = true
    }
    
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
    var selectedCellValue: Article?
    func navigateToDetailVC(selectedCell: Article?) {
        invokedNavigateToDetailVC = true
        selectedCellValue = selectedCell
    }
}
