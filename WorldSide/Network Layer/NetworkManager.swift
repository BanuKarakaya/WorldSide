//
//  NetworkManager.swift
//  Movie App
//
//  Created by Banu Karakaya on 15.09.2025.
//

import Foundation

protocol NetworkManagerInterface {
    func request<T: Decodable> (_ endpoint: Endpoint, completion: @escaping (Swift.Result  <T, Error>) -> Void) -> Void
    
    func getNews(completion: @escaping (Swift.Result<Response , Error>) -> Void) -> Void
    
    func getCnnNews(completion: @escaping (Swift.Result<Response , Error>) -> Void) -> Void
    
    func getSearchNews(completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void
}


final class NetworkManager: NetworkManagerInterface {
    static let shared = NetworkManager()
    
    private init() {} //
    
    func request<T:Decodable> (_ endpoint : Endpoint, completion : @escaping (Swift.Result  <T, Error>) ->Void) ->Void {
        
        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.request()) {(data ,response , error) in
            if let error = error {
                print(error)
            }
            if let response = response as? HTTPURLResponse {}
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonData))
                    
                }catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSessionTask.resume()
    }
    
    func getNews(completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.news(query: "access_key=3a600dcd8ea8c2a676f961ba0b6426f3")
        request(endpoint, completion: completion)
    }
    
    func getCnnNews(completion: @escaping (Swift.Result<Response , Error>) ->Void) -> Void {
        let endpoint = Endpoint.cnnNews(query: "access_key=3a600dcd8ea8c2a676f961ba0b6426f3")
        request(endpoint, completion: completion)
    }
    
    func getSearchNews (completion: @escaping (Swift.Result<Response , Error>) ->Void, searchText: String) -> Void {
        let endpoint = Endpoint.searchNews(searchText: searchText)
        request(endpoint, completion: completion)
    }
}


