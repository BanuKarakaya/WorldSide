

import Foundation

// MARK: - Welcome
struct Response: Codable {
    let pagination: Pagination
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let author: String?
    let title, description: String
    let url: String
    let source: Source
    let image: String?
    let category: Category
    let language, country: Country
    let publishedAt: Date

    enum CodingKeys: String, CodingKey {
        case author, title, description, url, source, image, category, language, country
        case publishedAt = "published_at"
    }
}

enum Category: String, Codable {
    case general = "general"
}

enum Country: String, Codable {
    case es = "es"
    case it = "it"
}

enum Source: String, Codable {
    case laopiniondezamora = "laopiniondezamora"
    case zazoom = "zazoom"
}

// MARK: - Pagination
struct Pagination: Codable {
    let limit, offset, count, total: Int
}

