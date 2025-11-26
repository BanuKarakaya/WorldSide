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
        sleep(1)
        print(app.debugDescription)
        
        // 1) Search tabına git
        app.tabBars.buttons["tab_search"].tap()
        
        // 2) Search bar var mı?
        let searchBar = app.searchFields["news_searchBar"]
        XCTAssertTrue(searchBar.waitForExistence(timeout: 3), "Search bar görünmüyor")
        
        // 3) Search bar'a yazı yaz
        searchBar.tap()
            searchBar.typeText("google")
            
            sleep(1) // API çağrısı için bekleme (Daha iyisi: expectation)

            // 4) Collection view var mı?
            let collectionView = app.collectionViews["news_collectionView"]
            XCTAssertTrue(collectionView.exists, "Collection view bulunamadı")

            // 5) En az 1 sonuç var mı?
            let firstCell = collectionView.cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "Filtrelenmiş ilk cell bulunamadı")

            // 6) İlk cell'deki title label var mı?
            let titleLabel = firstCell.staticTexts["news_cell_title"]
            XCTAssertTrue(titleLabel.exists, "Cell içindeki title label görünmüyor")

            // 7) İlk habere tıkla
            firstCell.tap()

            // 8) Detay ekranı açıldı mı?
            let detailTitle = app.staticTexts["detail_title"]
            XCTAssertTrue(detailTitle.waitForExistence(timeout: 3), "Detay ekranı açılmadı")
        }
    
    func test_ClearSearch() {
        app.tabBars.buttons["tab_search"].tap()

        let searchBar = app.searchFields["news_searchBar"]
        XCTAssertTrue(searchBar.exists)

        searchBar.tap()
        searchBar.typeText("perplexity")
        sleep(1)

        // Clear butonuna bas
        if app.buttons["Clear text"].exists {
            app.buttons["Clear text"].tap()
        }

        // Boş collection view değil, tüm liste geri gelmiş olmalı
        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.cells.count > 3, "Clear sonrası listede yeterli cell yok")
    }

    func test_CellContent() {

        app.tabBars.buttons["tab_search"].tap()

        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.exists)

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
