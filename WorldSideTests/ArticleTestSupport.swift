//
//  ArticleTestSupport.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

import Foundation
@testable import WorldSide
import CommonModule

extension Article {
    static func stub(
        title: String = "Title",
        description: String? = nil,
        url: String? = nil,
        urlToImage: String? = nil,
        sourceName: String = "Source",
        publishedAtISO8601: String = "2025-01-01T00:00:00Z"
    ) -> Article {
        var dict: [String: Any] = [
            "title": title,
            "source": ["name": sourceName],
            "publishedAt": publishedAtISO8601
        ]
        if let description { dict["description"] = description }
        if let url { dict["url"] = url }
        if let urlToImage { dict["urlToImage"] = urlToImage }
        
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try! decoder.decode(Article.self, from: data)
    }
}
