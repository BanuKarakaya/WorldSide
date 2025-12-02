//
//  Endpoint.swift
//  Movie App
//
//  Created by Banu Karakaya on 15.09.2025.
//

import Foundation

public enum Endpoint {
    case articles(query: String)
    case breakingNews(query: String)
    case searchArticles(searchText: String)
    case categoriesArticles(selectedCategories: String)
}

public enum HttpMethod: String {
    case get = "GET"
}

public protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    func request () -> URLRequest
}

extension Endpoint: EndpointProtocol {
    public var baseUrl: String {
        "https://newsapi.org/v2/"
    }
    
    public var path: String {
        switch self {
        case .articles(let query):
            return "everything?q=keyword\(query)"
        case .breakingNews(let query):
            return "top-headlines?country=us\(query)"
        case .searchArticles(let searchText):
            return "top-headlines?q=\(searchText)&apiKey=3981648866734d75902b4b10fc53ff32"
        case .categoriesArticles(let selectedCategories):
            return "top-headlines?category=\(selectedCategories)&apiKey=3981648866734d75902b4b10fc53ff32"
        }
    }
    
    public var method: HttpMethod {
        .get
    }
    
    public func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: URL(string: baseUrl+path)!)
        request.httpMethod = method.rawValue
        return request
    }
}
