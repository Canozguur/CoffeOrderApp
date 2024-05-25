//
//  iceCoffeesView.swift
//  mainProject
//
//  Created by Can Özgür on 2.05.2024.
//

import SwiftUI


struct iceCoffeesView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedSize: String? = nil
    
    let coffeemodel: CoffeeModel
    
    @State private var name = ""
    @State private var price: Double = 0.0
    @State private var size = ""
    
    var body: some View {
        ScrollView {
            VStack {
                // Image
                Image("\(coffeemodel.coffeeName)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 250)
                
                // Coffee Name
                Text("\(coffeemodel.coffeeName)")
                    .font(.title)
                    .bold()
                
                // Coffee Calories
                Text("Calories: \(coffeemodel.coffeeCalories)")
                    .foregroundStyle(.gray)
                
                // Size options
                VStack(alignment: .leading) {
                    Text("Size Options")
                        .bold()
                        .multilineTextAlignment(.trailing)
                    Divider().overlay(Color.yellow)
                        .frame(width: 350, height: 3)
                        .background(Color.yellow)
                }
                .padding()
                
                HStack {
                    // Small size coffee
                    Button(action: {
                        selectedSize = "Small"
                        size = "Small"
                        price = Double(coffeemodel.coffeeSmallPrice)
                    }) {
                        VStack {
                            Image("SmallSize")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 80)
                                .padding(25)
                            
                            // Price of coffee
                            Text("\(coffeemodel.coffeeSmallPrice) TL")
                                .foregroundStyle(selectedSize == "Small" ? .green : .primary)
                                .font(selectedSize == "Small" ? .title : .title3)
                        }
                    }
                    
                    // Medium size coffee
                    Button(action: {
                        selectedSize = "Medium"
                        size = "Medium"
                        price = Double(coffeemodel.coffeeMediumPrice)
                    }) {
                        VStack {
                            Image("MediumSize")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 80)
                                .padding(25)
                            
                            // Price of coffee
                            Text("\(coffeemodel.coffeeMediumPrice) TL")
                                .foregroundStyle(selectedSize == "Medium" ? .green : .primary)
                                .font(selectedSize == "Medium" ? .title : .title3)
                        }
                    }
                    
                    // Large size coffee
                    Button(action: {
                        selectedSize = "Large"
                        size = "Large"
                        price = Double(coffeemodel.coffeeLargePrice)
                    }) {
                        VStack {
                            Image("LargeSize")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 80)
                                .padding(25)
                            
                            // Price of coffee
                            Text("\(coffeemodel.coffeeLargePrice) TL")
                                .foregroundStyle(selectedSize == "Large" ? .green : .primary)
                                .font(selectedSize == "Large" ? .title : .title3)
                        }
                    }
                }
                
                // Add to ORDER button
                Button(action: {
                    // Save order
                    print("\(coffeemodel.coffeeName)")
                    print("\(size)")
                    print("\(price)")
                    DataController().addOrder(name: coffeemodel.coffeeName, price: price, size: size)
                    saveContext()
                    dismiss()
                    
                    
                }) {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .foregroundColor(Color("ColorOfButton"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        Text("Add to ORDER")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    .padding()
                }
            }
        }
        
    }
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
#Preview {

    return iceCoffeesView(coffeemodel: CoffeeModel(coffeeName: "100", coffeeCalories: 100, coffeeSmallPrice: 100, coffeeMediumPrice: 200, coffeeLargePrice: 300))
}
