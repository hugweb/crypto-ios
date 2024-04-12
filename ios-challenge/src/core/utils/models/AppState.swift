//
//  AppState.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import Foundation

class AppState: ObservableObject {
    
    @Published var currency: Currency = .dollar
    
    //TODO: This class could hold everything the app needs to share such as settings, etc..
}
