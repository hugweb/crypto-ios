//
//  Asset.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//
import Foundation
import SwiftData

@Model
class Asset: Identifiable, Codable {
    @Attribute(.unique)
    var id: String
    var rank: String
    var symbol: String
    var name: String
    var supply: String
    var maxSupply: String
    var marketCapUsd: String
    var volumeUsd24Hr: String
    var priceUsd: String
    var changePercent24Hr: String
    var vwap24Hr: String
    
    init(id: String, 
         rank: String,
         symbol: String,
         name: String, 
         supply: String,
         maxSupply: String,
         marketCapUsd: String,
         volumeUsd24Hr: String,
         priceUsd: String,
         changePercent24Hr: String,
         vwap24Hr: String) {
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
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.rank = try container.decodeIfPresent(String.self, forKey: .rank) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
        self.supply = try container.decodeIfPresent(String.self, forKey: .supply) ?? ""
        self.maxSupply = try container.decodeIfPresent(String.self, forKey: .maxSupply) ?? ""
        self.marketCapUsd = try container.decodeIfPresent(String.self, forKey: .marketCapUsd) ?? ""
        self.volumeUsd24Hr = try container.decodeIfPresent(String.self, forKey: .volumeUsd24Hr) ?? ""
        self.priceUsd = try container.decodeIfPresent(String.self, forKey: .priceUsd) ?? ""
        self.changePercent24Hr = try container.decodeIfPresent(String.self, forKey: .changePercent24Hr) ?? ""
        self.vwap24Hr = try container.decodeIfPresent(String.self, forKey: .vwap24Hr) ?? ""
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

extension Asset {
    
    var bullish: Bool {
        return !changePercent24Hr.hasPrefix("-")
    }
    
    var percentage24h: String {
        let formatter = NumberFormatter()
        let double = formatter.number(from: changePercent24Hr)
        return double?.doubleValue.formatted(.number.precision(.fractionLength(0...2))) ?? ""
    }
    
    var currentPrice: Double? {
        return Double(priceUsd)
    }
}
