//
//  AssetListRow.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct AssetListRow: View {
    
    let asset: Asset
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(asset.name)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.black.opacity(0.9))
                    Text(asset.symbol)
                        .foregroundStyle(Color.black.opacity(0.5))
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$\(asset.priceUsd)")
                        .foregroundStyle(Color.black.opacity(0.7))
                        .font(.footnote)
                    HStack {
                        Text(asset.percentage24h)
                            .font(.footnote)
                        Image(systemName: asset.bullish ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                    }
                    .foregroundStyle(asset.bullish ? Color.green : Color.red)
                }
            }
        }
    }
}

#Preview {
    let asset = Asset(id: "bitcoin",
                      rank: "1",
                      symbol: "BTC",
                      name: "Bitcoin",
                      supply: "17193925.0000000000000000",
                      maxSupply: "21000000.0000000000000000",
                      marketCapUsd: "119150835874.4699281625807300",
                      volumeUsd24Hr: "2927959461.1750323310959460",
                      priceUsd: "6929.8217756835584756",
                      changePercent24Hr: "-0.8101417214350335",
                      vwap24Hr: "7175.0663247679233209")
    return AssetListRow(asset: asset)
}
