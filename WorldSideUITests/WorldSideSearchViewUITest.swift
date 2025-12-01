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
        // TabBar'ın yüklenmesini bekle (Splash ekranı 6 saniye sürüyor)
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "TabBar yüklenemedi")
        
        // 1) Search tabına git
        let searchTab = app.tabBars.buttons["Search"]
        XCTAssertTrue(searchTab.waitForExistence(timeout: 3), "Search tab bulunamadı")
        searchTab.tap()
        
        // 2) Search bar var mı? (UISearchController kullanıldığında NavigationBar içinde)
        // SearchBar'ı göstermek için CollectionView'ı aşağı kaydır
        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view bulunamadı")
        collectionView.swipeDown()
        
        let searchBar = app.searchFields.firstMatch
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar görünmüyor")
        
        // 3) Search bar'a yazı yaz
        searchBar.tap()
        searchBar.typeText("google")
        
        // Klavyeyi kapat (Search butonuna bas)
        app.keyboards.buttons["Search"].tap()
        
        sleep(2) // API çağrısı için bekleme

        // 4) En az 1 sonuç var mı?
        let firstCell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "Filtrelenmiş ilk cell bulunamadı")

        // 5) İlk cell'deki title label var mı?
        let titleLabel = firstCell.staticTexts["news_cell_title"]
        XCTAssertTrue(titleLabel.exists, "Cell içindeki title label görünmüyor")

        // 6) İlk habere tıkla
        firstCell.tap()

        // 7) Detay ekranı açıldı mı? (Navigation animasyonu için daha fazla süre ver)
        let detailTitle = app.staticTexts["detail_title"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 10), "Detay ekranı açılmadı")
    }
    
    func test_ClearSearch() {
        // TabBar'ın yüklenmesini bekle
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 10), "TabBar yüklenemedi")
        
        app.tabBars.buttons["Search"].tap()

        // SearchBar'ı göstermek için CollectionView'ı aşağı kaydır
        let collectionView = app.collectionViews["news_collectionView"]
        XCTAssertTrue(collectionView.waitForExistence(timeout: 5), "Collection view bulunamadı")
        collectionView.swipeDown()
        
        let searchBar = app.searchFields.firstMatch
        XCTAssertTrue(searchBar.waitForExistence(timeout: 5), "Search bar görünmüyor")

        searchBar.tap()
        searchBar.typeText("perplexity")
        sleep(1)

        // Clear butonuna bas (SearchBar aktifken görünür)
        let clearButton = app.buttons["Clear text"]
        if clearButton.waitForExistence(timeout: 3) {
            clearButton.tap()
        }

        // Boş collection view değil, tüm liste geri gelmiş olmalı
        XCTAssertTrue(collectionView.cells.count > 3, "Clear sonrası listede yeterli cell yok")
    }

    func test_CellContent() {
        // TabBar'ın yüklenmesini bekle
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
