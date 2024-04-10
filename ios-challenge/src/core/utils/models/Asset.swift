//
//  Asset.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftData

@Model
class Asset: Identifiable, Codable {
    @Attribute(.unique)
    var id: String
    var rank: Int
    var symbol: String
    var name: String
    var supply: Double
    var maxSupply: Double
    var marketCapUsd: Double
    var volumeUsd24Hr: Double
    var priceUsd: Double
    var changePercent24Hr: Double
    var vwap24Hr: Double
    
    init(id: String, 
         rank: Int,
         symbol: String,
         name: String, 
         supply: Double,
         maxSupply: Double,
         marketCapUsd: Double,
         volumeUsd24Hr: Double,
         priceUsd: Double,
         changePercent24Hr: Double,
         vwap24Hr: Double) {
        self.id = id
        self.rank = rank
        self.symbol = symbol
        self.name = name
        self.supply = supply
        self.maxSupply = maxSupply
        self.marketCapUsd = marketCapUsd
        self.volumeUsd24Hr = volumeUsd24Hr
        self.priceUsd = priceUsd
        self.changePercent24Hr = changePercent24Hr
        self.vwap24Hr = vwap24Hr
    }
    
    enum CodingKeys: String, CodingKey {
        case id, rank, name, symbol, supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.rank = try container.decodeIfPresent(Int.self, forKey: .rank) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.supply = try container.decodeIfPresent(Double.self, forKey: .supply) ?? 0.0
        self.maxSupply = try container.decodeIfPresent(Double.self, forKey: .supply) ?? 0.0
        self.marketCapUsd = try container.decodeIfPresent(Double.self, forKey: .supply)  ?? 0.0
        self.volumeUsd24Hr = try container.decodeIfPresent(Double.self, forKey: .supply)  ?? 0.0
        self.priceUsd = try container.decodeIfPresent(Double.self, forKey: .supply)  ?? 0.0
        self.changePercent24Hr = try container.decodeIfPresent(Double.self, forKey: .supply)  ?? 0.0
        self.vwap24Hr = try container.decodeIfPresent(Double.self, forKey: .supply) ?? 0.0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(rank, forKey: .rank)
        try container.encode(name, forKey: .name)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(supply, forKey: .supply)
        try container.encode(maxSupply, forKey: .maxSupply)
        try container.encode(marketCapUsd, forKey: .marketCapUsd)
        try container.encode(volumeUsd24Hr, forKey: .volumeUsd24Hr)
        try container.encode(priceUsd, forKey: .priceUsd)
        try container.encode(changePercent24Hr, forKey: .changePercent24Hr)
        try container.encode(vwap24Hr, forKey: .vwap24Hr)
    }
}
