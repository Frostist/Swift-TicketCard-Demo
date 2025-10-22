//
//  MenuView.swift
//  MarsTicketSystem
//
//  Created by Will Frost on 20/08/2024.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                // Menu Item 1
                NavigationLink(destination: HomeView1()) {
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundColor(.blue)
                        Text("Home")
                            .font(.headline)
                    }
                }
                
                // Menu Item 2
                NavigationLink(destination: ProfileView2()) {
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.green)
                        Text("Profile")
                            .font(.headline)
                    }
                }
                
                // Menu Item 3
                NavigationLink(destination: GeneralView3()) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.gray)
                        Text("Settings")
                            .font(.headline)
                    }
                }
                
                // Menu Item 4
                NavigationLink(destination: AboutView4()) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.purple)
                        Text("About")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}

// Example destination views
struct HomeView1: View {
    var body: some View {
        Text("Home Screen")
            .font(.largeTitle)
            .navigationTitle("Home")
    }
}

struct ProfileView2: View {
    var body: some View {
        Text("Profile Screen")
            .font(.largeTitle)
            .navigationTitle("Profile")
    }
}

struct GeneralView3: View {
    var body: some View {
        Text("Settings Screen")
            .font(.largeTitle)
            .navigationTitle("Settings")
    }
}

struct AboutView4: View {
    var body: some View {
        Text("About Screen")
            .font(.largeTitle)
            .navigationTitle("About")
    }
}


#Preview {
    SettingsView()
}
