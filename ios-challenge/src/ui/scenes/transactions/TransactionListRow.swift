//
//  TransactionListRow.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import SwiftUI

struct TransactionListRow: View {
    
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(transaction.date, style: .date)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.9))
                Spacer()
                Text(transaction.symbol)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.7))
            }
            HStack {
                Text(transaction.humanizeValue)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black.opacity(0.7))
                Spacer()
                if let humanizePrice = transaction.humanizePrice {
                    Text(humanizePrice)
                        .font(.footnote)
                        .foregroundStyle(Color.black.opacity(0.7))
                }
            }
        }
    }
}
