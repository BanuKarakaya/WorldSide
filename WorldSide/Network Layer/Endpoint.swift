//
//  Endpoint.swift
//  Movie App
//
//  Created by Banu Karakaya on 15.09.2025.
//

import Foundation

enum Endpoint {
    case news(query: String)
    case cnnNews(query: String)
    case searchNews(searchText: String)
}

enum HttpMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var baseUrl: String {get}
    var path : String {get}
    func request () -> URLRequest
}

extension Endpoint: EndpointProtocol {
    var baseUrl: String {
        "https://api.mediastack.com/v1/"
    }
    
    var path: String {
        switch self {
        case .news(let query):
            return "news?\(query)"
        case .cnnNews(let query):
            return "news?\(query)&sources=cnn"
        case .searchNews(let searchText):
            return "sources?access_key=3a600dcd8ea8c2a676f961ba0b6426f3&search=\(searchText)"
        }
    }
    
    var method: HttpMethod {
        .get
    }
    
    func request() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else {
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: URL(string: baseUrl+path)!)
        request.httpMethod = method.rawValue
        return request
    }
}
