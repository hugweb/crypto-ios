//
//  AssetResponse.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

struct AssetResponse: Codable {
    let data: [Asset]
    let timestamp: TimeInterval
}
