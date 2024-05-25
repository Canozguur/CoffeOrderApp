//
//  OrderView.swift
//  mainProject
//
//  Created by Can Özgür on 20.05.2024.
//

import SwiftUI
import CoreData

struct OrderView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Coffee.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Coffee.name, ascending: true)]
    ) var coffees: FetchedResults<Coffee>
    
    @FetchRequest(
        entity: Profile.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Profile.city, ascending: true)]
    ) var profiles: FetchedResults<Profile>
    
    @State private var showingAlert = false
    @State private var showingSecondAlert = false
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    Text("ORDER")
                        .bold()
                        .font(.title)
                    Spacer()
                }
                .padding()
                Divider()
                VStack {
                    HStack {
                        Text("\(coffees.count) items")
                        Spacer()
                        Text("Total Price: \(Int(totalPrice())) TL")
                            .bold()
                            .font(.title3)
                    }
                    .padding()
                    HStack {
                        Text("Coffees")
                            .foregroundStyle(.blue)
                            .bold()
                        Spacer()
                    }
                    .padding()
                }
                
                Divider()
                
                List{
                    ForEach(coffees) { coffee in
                        HStack {
                            HStack {
                                Text(coffee.size ?? "") + Text(" \(coffee.name ?? "")")
                                    .bold()
                                Spacer()
                                Text("\(Int(coffee.price)) TL")
                                    .font(.title2)
                                    .bold()
                            }
                            Spacer()
                        }
                        
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            indexSet.map { coffees[$0] }.forEach(managedObjectContext.delete)
                            saveContext()
                            
                        }
                    }
                    
                }
                .listStyle(.plain)
                VStack{
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Address")
                                .bold()
                            if let profile = profiles.first {
                                Text(profile.city ?? "Unknown City") + Text(profile.country ?? "Unknown Country")
                                Text(profile.adresline1 ?? "Unknown Address")
                                Text(profile.adresline2 ?? "Unknown Address")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("No address available")
                            }
                        }
                    }
                    .padding()
                    // Make an Order Confirm Button
                    Button(action: {
                        showingAlert = true
                    },
                           label:{
                        Text("Make an Order")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(width: 340, height: 50)
                            .background(Color("OrderButtonColor"))
                            .cornerRadius(10)
                    })
                    .alert(isPresented:$showingAlert) 
                    {
                        Alert(
                            title: Text("The Order Completed"),
                            message: Text("Order is on the way "),
                            primaryButton: .destructive(Text("Cancel")) {
                                
                            },
                            secondaryButton: .default(Text("Pay"),action: {
                                showingSecondAlert = true
                            } )
                        )
                    }
                    .alert("Payment Completed", isPresented: $showingSecondAlert) {
                                Button("OK") {
                                    deleteAllCoffees()
                                    print("Deleted")
                                }
                            }
                
                }
            }
            .navigationTitle("Your ORDER")
            .navigationBarTitleDisplayMode(.inline)
            
        }
      
    }
    
    private func totalPrice() -> Double {
        return coffees.reduce(0.0) { $0 + ($1.price) }
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    // for payment deleting all coffees datas
    private func deleteAllCoffees() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Coffee")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedObjectContext.execute(batchDeleteRequest)
            try managedObjectContext.save()
        } catch {
            print("Error deleting all coffees: \(error)")
        }
    }
    
    
}
#Preview {
    let context = DataController.shared.container.viewContext
    
    return OrderView()
        .environment(\.managedObjectContext, context)
       
    
}
