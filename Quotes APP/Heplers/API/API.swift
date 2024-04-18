//
//  API.swift
//  Squeezee
//
//  Created by AKASH on 04/08/23.
//

import Foundation

// MARK: - API
enum API {
    case quotes(type: String)
}

// MARK: - APIProtocol
extension API: APIProtocol {
    var baseURL: String {
        "https://api.api-ninjas.com/v1/"
    }
    
    var path: String {
        switch self {
        case .quotes:
            return "quotes"
        }
    }
    
    var method: APIMethod {
        switch self {
        case .quotes:
            return .get
        }
    }
    
    var task: Request {
        switch self {
        case let .quotes(type):
            return .queryString(["category": type])
        }
    }
    
    var header: [String: String] {
        switch self {
        case .quotes:
            return [
                "Content-Type" : "application/json",
                "X-Api-Key": API_KEY
            ]
        }
    }
}
