//
//  CoinXpressApp.swift
//  CoinXpress
//
//  Created by Paul Frank Pacheco Carpio on 17/11/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct CoinXpressApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: CoinXpressApp.store)
        }
    }
}
