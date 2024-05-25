//
//  Profileview.swift
//  mainProject
//
//  Created by Can Özgür on 18.05.2024.
//

import SwiftUI
struct ProfileCof: Identifiable {
    let id = UUID()
    let name: String
    let date: String
}
struct Profileview: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: [] 
    ) var profiles: FetchedResults<Profile>
    
    @State private var isSettingsViewActive = false
    
    
    let coffees = [
        ProfileCof(name: "Cappuccino", date: "10 min ago"),
        ProfileCof(name: "Latte", date: "2 days ago"),
        ProfileCof(name: "Latte", date: "2 days ago"),
        ProfileCof(name: "Espresso", date: "1 week ago"),
  
    ]
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack(alignment: .top) {
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Button(action: { isSettingsViewActive = true
                            print("clicked")}, label: {
                                Text("Settings")
                            })
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("#Can Ozgur")
                            .bold()
                            .padding()
                        Text("Total orders: 4")
                            .bold()
                    }
                    .padding()
                }
                // --- TOP part of Profile
                Divider()
                // Day message
                Text("Good Morning")
                    .font(.title)
                Divider()
                // List Itemslari yaz
                List(coffees) { coffee in
                    HStack {
                        HStack {
                            Text(coffee.name)
                                .font(.headline)
                            Spacer()
                            Text(coffee.date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                    
                }.listStyle(.plain)
                
                Spacer()
            }
            .navigationDestination(isPresented: $isSettingsViewActive) {
                if let profile = profiles.first {
                    SettingsView(profile: profile)
                } else {
                    Text("No profile found.")
                }
        }

        }
    }
}


#Preview {
    // Provide a mock Profile for the preview
    let context = DataController.shared.container.viewContext
    let profile = Profile(context: context)
    profile.adresline1 = "123 Main St"
    profile.adresline2 = "Apt 4B"
    profile.city = "Istanbul"
    profile.country = "Turkey"

    
    return Profileview()
        .environment(\.managedObjectContext, context)
}
