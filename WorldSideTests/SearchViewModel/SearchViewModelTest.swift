//
//  SearchViewModelTest.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

import XCTest
@testable import WorldSide
import NetworkLayer
import CommonModule

final class SearchViewModelTest: XCTestCase {
    private var viewModel: SearchViewModel!
    private var view: MockSearchViewController!
    private var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        networkManager = .init()
        viewModel = .init(delegate: view, networkManager: networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_viewDidLoad_GetNewsCompletionIsSuccess_InvokesRequiredMethod() {
        networkManager.shouldSuccessCompletionInGetArticles = true
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareSearchBar)
        XCTAssertFalse(networkManager.invokedFetchNews)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedPrepareSearchBar)
        XCTAssertTrue(networkManager.invokedFetchNews)
    }
    
    func test_viewDidLoad_GetNewsCompletionIsFailure_InvokesRequiredMethod() {
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(view.invokedPrepareSearchBar)
        XCTAssertFalse(networkManager.invokedFetchNews)
        viewModel.viewDidLoad()
        XCTAssertTrue(view.invokedPrepareCollectionView)
        XCTAssertTrue(view.invokedPrepareSearchBar)
        XCTAssertTrue(networkManager.invokedFetchNews)
    }
    
    func test_searchBarCancelButtonClicked_InvokedRequiredMethod() {
        XCTAssertFalse(view.invokedReloadData)
        viewModel.searchBarCancelButtonClicked()
        XCTAssertTrue(view.invokedReloadData)
    }
    
    func test_searchBarSearchButtonClicked_searchTextIsNil_Returns() {
        
    }
    
    func test_searchBarSearchButtonClicked_InvokedRequiredMethod() {
        
    }
    
    func test_didSelectItemAt_usesNewsArray_whenNotSearching() {
        viewModel.isSearching = false
        let selectedCell: Article = Article.stub(title: "A0")

        networkManager.shouldSuccessCompletionInGetArticles = true
        networkManager.stubbedResponse = Response.init(status: "", totalResults: 0, articles: [selectedCell])
        viewModel.fetchNews()
        XCTAssertNil(view.selectedCellValue)
        XCTAssertFalse(view.invokedNavigateToDetailVC)
        
        viewModel.didSelectItemAt(index: 0)
        
        XCTAssertTrue(view.invokedNavigateToDetailVC)
        XCTAssertEqual(view.selectedCellValue?.title, selectedCell.title)
    }
    
    func test_didSelectItemAt_usesNewsArray_whenSearching() {
        viewModel.isSearching = true
        let selectedCell: Article = Article.stub(title: "A1")
        
        networkManager.shouldSuccessCompletionInGetSearchArticles = true
        networkManager.stubbedSearchResponse = Response.init(status: "", totalResults: 0, articles: [selectedCell])
        viewModel.fetchSearchArticles(searchedText: "banu")
        XCTAssertNil(view.selectedCellValue)
        XCTAssertFalse(view.invokedNavigateToDetailVC)
        
        viewModel.didSelectItemAt(index: 0)
        
        XCTAssertTrue(view.invokedNavigateToDetailVC)
        XCTAssertEqual(view.selectedCellValue?.title, selectedCell.title)
    }
    
    func test_newsAtIndex_isSearchingIsTrue_returnsSearchArray() {
        
    }
    
    func test_newsAtIndex_isSearchingIsFalse_returnsNewsArray() {
        let selectedCell: Article = Article.stub(title: "A1")
        networkManager.shouldSuccessCompletionInGetSearchArticles = true
        networkManager.stubbedSearchResponse = Response.init(status: "", totalResults: 0, articles: [selectedCell])
        viewModel.fetchSearchArticles(searchedText: "banu")
        XCTAssertEqual(viewModel.newsAtIndex(index: 0)?.title, selectedCell.title)
    }
}
