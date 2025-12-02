
import Foundation

// MARK: - Response
public struct Response: Decodable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
    
    public init(status: String, totalResults: Int, articles: [Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}

// MARK: - Article
public struct Article: Decodable {
    public let source: Source
    public let author: String?
    public let title, description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
}

// MARK: - Source
public struct Source: Decodable {
    public let id: String?
    public let name: String
}
