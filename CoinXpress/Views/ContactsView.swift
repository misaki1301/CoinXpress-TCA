//
//  ContactsView.swift
//  CoinXpress
//
//  Created by Paul Frank Pacheco Carpio on 18/11/23.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        Text(contact.name)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
        .sheet(store: store.scope(state: \.$addContact, action: {.addContact($0)})) { addContactStore in
            NavigationStack {
                AddContactView(store: addContactStore)
            }
        }
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(contacts: [
        Contact(id: UUID(), name: "Shoko Makinohara"),
        Contact(id: UUID(), name: "Mai Sakurajima"),
        Contact(id: UUID(), name: "Kaede Asuzagawa"),
    ]), reducer: {
        ContactsFeature()
    }))
}
