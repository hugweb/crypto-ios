//
//  AppErrorView.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct ErrorView: View {
    
    let onTryAgain: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.red)
            .padding(40)
            .overlay {
                VStack {
                    Button(LocalizedStringKey("Try again")) {
                        onTryAgain()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
    }
}
