//
//  ContentView.swift
//  CoinXpress
//
//  Created by Paul Frank Pacheco Carpio on 17/11/23.
//

import SwiftUI
import ComposableArchitecture

extension CounterFeature.State: Equatable {
    static func == (lhs: CounterFeature.State, rhs: CounterFeature.State) -> Bool {
        lhs.count == rhs.count && lhs.isLoading == rhs.isLoading && lhs.fact == rhs.fact
    }
}

struct ContentView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            VStack {
                Text("\(viewStore.count)")
                    .font(.largeTitle)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Button("-") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(10)
                    
                    Button("+") {
                        viewStore.send(.incrementButtonTapped)
                    }.font(.largeTitle)
                        .padding()
                        .background(.black.opacity(0.1))
                        .cornerRadius(10)
                    Button(viewStore.isTimerRunning ? "Stop Timer" : "Start Timer") {
                        viewStore.send(.toggleTimerButtonTapped)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(.black.opacity(0.1))
                    .cornerRadius(10)
                }
                Button("Fact") {
                          viewStore.send(.factButtonTapped)
                        }
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black.opacity(0.1))
                        .cornerRadius(10)
                
                if viewStore.isLoading {
                    ProgressView()
                }
                if let fact = viewStore.fact {
                    Text(fact)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        })
}
