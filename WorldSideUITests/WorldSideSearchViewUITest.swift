//
//  WorldSideSearchViewUITest.swift
//  WorldSideSearchViewUITest
//
//  Created by Banu Karakaya on 23.10.2025.
//

import XCTest

final class WorldSideSearchViewUITest: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
  
    func test_SearchFlow() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "TabBar yüklenemedi")
        
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.waitForExistence(timeout: 3), "Search tab bulunamadı")
        searchTab.tap()
        
        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view bulunamadı")
        collectionView.swipeDown()
        
        let searchBar = app.searchFields.firstMatch
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar görünmüyor")
   
        searchBar.tap()
        searchBar.typeText("google")
        
        app.keyboards.buttons["Search"].tap()
        
        sleep(2)

        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "Filtrelenmiş ilk cell bulunamadı")

        let titleLabel = firstCell.staticTexts["news_cell_title"]
        XCTAssertTrue(titleLabel.exists, "Cell içindeki title label görünmüyor")

        firstCell.tap()

        let detailTitle = app.staticTexts["detail_title"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 10), "Detay ekranı açılmadı")
    }
    
    func test_ClearSearch() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "TabBar yüklenemedi")
        
        app.tabBars.buttons["Search"].tap()

        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view bulunamadı")
        collectionView.swipeDown()
        
        let searchBar = app.searchFields.firstMatch
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar görünmüyor")

        searchBar.tap()
        searchBar.typeText("perplexity")
        sleep(1)

        let clearButton = app.buttons["Clear text"]
        if clearButton.waitForExistence(timeout: 3) {
            clearButton.tap()
        }

        XCTAssertTrue(collectionView.cells.count > 3, "Clear sonrası listede yeterli cell yok")
    }

    func test_CellContent() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "TabBar yüklenemedi")
        
        app.tabBars.buttons["Search"].tap()

        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view bulunamadı")

        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 4))

        let titleLabel = firstCell.staticTexts["news_cell_title"]
        let sourceLabel = firstCell.staticTexts["news_cell_source"]

        XCTAssertTrue(titleLabel.exists)
        XCTAssertTrue(sourceLabel.exists)

        XCTAssertFalse(titleLabel.label.isEmpty, "Title boş")
        XCTAssertFalse(sourceLabel.label.isEmpty, "Source boş")
    }
}
