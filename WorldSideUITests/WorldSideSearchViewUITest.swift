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
            
            // 1) Search tabına git
            app.tabBars.buttons["Search"].tap()

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
}
