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
    func request<T>(_ endpoint: NetworkLayer.Endpoint, completion: @escaping (Result<T, NetworkLayer.NetworkErrors>) -> Void) where T : Decodable {
    }
    
    var shouldSuccessCompletionInGetArticles = false
    var stubbedResponse: Response!
    var invokedFetchNews = false
    func getArticles(completion: @escaping (Result<CommonModule.Response, NetworkLayer.NetworkErrors>) -> Void) {
        invokedFetchNews = true
        if shouldSuccessCompletionInGetArticles {
            if let response = stubbedResponse {
                completion(.success(response))
            } else {
                completion(.failure(.urlRequestFailed))
            }
        } else {
            completion(.failure(.decodingFailed))
        }
    }
    
    var invokedFetchBreakingNews = false
    func getBreakingNews(completion: @escaping (Result<CommonModule.Response, NetworkLayer.NetworkErrors>) -> Void) {
        invokedFetchBreakingNews = true
    }
    
    var shouldSuccessCompletionInGetSearchArticles = false
    var stubbedSearchResponse: Response!
    var invokedSearchNews = false
    func getSearchArticles(completion: @escaping (Result<CommonModule.Response, NetworkLayer.NetworkErrors>) -> Void, searchText: String) {
        invokedSearchNews = true
        if shouldSuccessCompletionInGetSearchArticles {
            if let response = stubbedSearchResponse {
                completion(.success(response))
            } else {
                completion(.failure(.urlRequestFailed))
            }
        } else {
            completion(.failure(.decodingFailed))
        }
    }
    
    func getCategoriesArticles(completion: @escaping (Result<CommonModule.Response, NetworkLayer.NetworkErrors>) -> Void, categoriesWord: String) {
        
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

enum MockError: Error {
    case nilStubbedResponse
    case failed
}
