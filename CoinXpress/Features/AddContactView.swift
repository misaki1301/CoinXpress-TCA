//
//  AddContactView.swift
//  CoinXpress
//
//  Created by Paul Frank Pacheco Carpio on 19/11/23.
//

import ComposableArchitecture
import SwiftUI

struct AddContactView: View {
    let store: StoreOf<AddContactFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                TextField("Name", text: viewStore.binding(get: \.contact.name, send: { .setName($0) }))
                Button("Save") {
                    viewStore.send(.saveButtonTapped)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        viewStore.send(.cancelButtonTapped)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddContactView(store: Store(initialState: AddContactFeature.State(contact: Contact(id: UUID(), name: "Makinohara Shoko"))) {
            AddContactFeature()
        }
        )
    }
}
