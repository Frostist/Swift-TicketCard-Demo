//
//  HomeView.swift
//  MarsTicketSystem
//
//  Created by Will Frost on 29/08/2024.
//
//
//  HomeView.swift
//  MarsTicketSystem
//
//  Created by Will Frost on 29/08/2024.
//

import SwiftUI

struct MenuItem {
    let smallTitle: String
    let title: String
    let systemImage: String
    let detailText: String
}

struct HomeView: View {
    let items = [
        MenuItem(smallTitle: "Mars Home", title: "Book a place on Mars 🌍", systemImage: "globe", detailText: "Explore Mars and book a ticket to the red planet."),
        MenuItem(smallTitle: "Rocket Trip", title: "Book a seat on the rocket 🚀", systemImage: "flame.fill", detailText: "Secure your spot on the next rocket to Mars."),
        MenuItem(smallTitle: "Extra Stuff", title: "Extra Stuff", systemImage: "bag.fill", detailText: "Extras and other useful items for your journey.")
    ]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Welcome")) {
                    Text("Welcome to Mars Pass!")
                        .font(.headline)
                        .padding(.vertical, 8)
                    
                    Text("View your Mars Pass subscription details below!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                }
                
                Section(header: Text("Topics")) {
                    ForEach(items, id: \.title) { item in
                        NavigationLink(destination: DetailView(title: item.smallTitle, detailText: item.detailText)) {
                            Label(item.title, systemImage: item.systemImage)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Home")
        }
    }
}


struct DetailView: View {
    let title: String
    let detailText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Details for \(title)")
                .font(.largeTitle)
                .bold()
            
            Text(detailText)
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}

#Preview {
    HomeView()
}
