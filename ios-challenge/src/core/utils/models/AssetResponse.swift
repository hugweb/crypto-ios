//
//  AssetResponse.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

struct AssetResponse: Codable, Equatable {
    let data: [Asset]
    let timestamp: TimeInterval
}
