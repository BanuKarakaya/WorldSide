//
//  MockNetworkManager.swift
//  WorldSideTests
//
//  Created by Banu Karakaya on 26.11.2025.
//

import Foundation
@testable import WorldSide
import NetworkLayer
import CommonModule

final class MockNetworkManager: NetworkManagerInterface {
    func request<T>(_ endpoint: Endpoint, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        
    }
    
    var shouldSuccessCompletionInGetArticles = false
    var stubbedResponse: Response!
    var invokedFetchNews = false
    func getArticles(completion: @escaping (Result<Response, any Error>) -> Void) {
        invokedFetchNews = true
        if shouldSuccessCompletionInGetArticles {
            completion(.success(stubbedResponse))
        } else {
         // failure case
        }
    }
    
    var invokedFetchBreakingNews = false
    func getBreakingNews(completion: @escaping (Result<Response, any Error>) -> Void) {
        invokedFetchBreakingNews = true
    }
    
    var shouldSuccessCompletionInGetSearchArticles = false
    var stubbedSearchResponse: Response!
    var invokedSearchNews = false
    func getSearchArticles(completion: @escaping (Result<Response, any Error>) -> Void, searchText: String) {
      invokedSearchNews = true
        if shouldSuccessCompletionInGetSearchArticles {
            completion(.success(stubbedSearchResponse))
        } else {
            // failure case
        }
    }
    
    func getCategoriesArticles(completion: @escaping (Result<Response, any Error>) -> Void, categoriesWord: String) {
        
    }
}

extension Response {
    static var response: Response {
        let bundle = Bundle(for: MockNetworkManager.self)
        let path = bundle.path(forResource: "ArticleResponse", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let article = try! JSONDecoder().decode(Response.self, from: data)
        return article
    }
}
