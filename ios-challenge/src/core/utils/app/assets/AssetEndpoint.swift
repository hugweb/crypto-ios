//
//  AssetEndpoint.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

enum AssetEndpoint: ApiEndpoint {
    
    case assets
    
    var path: String {
        switch self {
        case .assets:
            return "assets"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .assets:
            return .get
        }
    }
    
    var query: [String : String]? {
        switch self {
        case .assets:
            return [:]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .assets:
            return [:]
        }
    }
}
