//
//  ContentView.swift
//  RealmTestProject
//
//  Created by Влад Мади on 27.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            PeopleView()
                .navigationTitle("Клуб собаководов")
        }
        .onAppear { print(RealmService.shared.getUrl()) }
    }
}

#Preview {
    ContentView()
}
