//
//  NetworkErrors.swift
//  NetworkLayer
//
//  Created by Banu Karakaya on 2.12.2025.
//

public enum NetworkErrors: Error {
    case noInternetConnection
    case decodingFailed
    case urlRequestFailed
    
    public var title: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .decodingFailed:
            return "Decoding failed"
        case .urlRequestFailed:
            return "URLRequest failed"
        }
    }
    
    public var message: String {
        switch self {
        case .noInternetConnection:
            return "Please check your internet connection."
        case .decodingFailed:
            return "Decoding failed. Please try again."
        case .urlRequestFailed:
            return "URLRequest failed. Please try again."
        }
    }
}
