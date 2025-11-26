//
//  SearchViewModelTest.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

import XCTest
@testable import WorldSide

final class SearchViewModelTest: XCTestCase {
    private var viewModel: SearchViewModel!
    private var view: MockSearchViewController!
    
    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(delegate: view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_viewDidLoad_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareSearchBar)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedPrepareSearchBar)
        
    }
    
    func test_searchBarCancelButtonClicked_InvokedRequiredMethof() {
        XCTAssertFalse(view.invokedReloadData)
        viewModel.searchBarCancelButtonClicked()
        XCTAssertTrue(view.invokedReloadData)
    }
    
    
}
