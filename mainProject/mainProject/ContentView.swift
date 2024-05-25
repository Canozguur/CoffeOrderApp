//
//  ContentView.swift
//  mainProject
//
//  Created by Can Özgür on 2.05.2024.
//

import SwiftUI
struct CoffeeModel : Hashable {
    let coffeeName : String // using string type for coffee name
    let coffeeCalories : Int // using integer type for coffee calories
    let coffeeSmallPrice : Int // using integer type for coffee price of small size
    let coffeeMediumPrice : Int // using integer type for coffee price of medium size
    let coffeeLargePrice : Int // using integer type for coffee price of large size
}

struct ContentView: View {
    @State private var showIceCoffeesView = false
    //datas
    
    var coffees1 : [CoffeeModel] = [
        .init(coffeeName: "Cappucino",
              coffeeCalories: 200,
              coffeeSmallPrice: 100,
              coffeeMediumPrice: 120,
              coffeeLargePrice: 150),
        .init(coffeeName: "Espresso",
              coffeeCalories: 150,
              coffeeSmallPrice: 50,
              coffeeMediumPrice: 70,
              coffeeLargePrice: 90),
        .init(coffeeName: "Mocha",
              coffeeCalories: 200,
              coffeeSmallPrice: 100,
              coffeeMediumPrice: 120,
              coffeeLargePrice: 150),
        .init(coffeeName: "Latte",
              coffeeCalories: 150,
              coffeeSmallPrice: 50,
              coffeeMediumPrice: 70,
              coffeeLargePrice: 90),
        .init(coffeeName: "Americano",
              coffeeCalories: 200,
              coffeeSmallPrice: 75,
              coffeeMediumPrice: 80,
              coffeeLargePrice: 85)
    ]
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    var body: some View {
        // creating Bottom Navigations Views with .tabItem{}
        TabView{
            // creating top Navigations View
            NavigationStack{
                // add scroll view on the screen
                ScrollView{
                    // add 2 grid on the screen to fit the coffees items
                    LazyVGrid(columns: adaptiveColumns, spacing: 20){
                        ForEach(coffees1, id: \.coffeeName){ coffee in
                            NavigationLink(destination: iceCoffeesView(coffeemodel: coffee
                                
                            )){
                                // vertical space for each coffee
                                VStack{
                                    //image of the coffee
                                    Image(coffee.coffeeName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 170, height: 170)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    // name of the coffee
                                    Text("\(coffee.coffeeName)")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24))
                                }
                            }
                        }
                    }
                }
                // Settings of top navigationview part
                .padding()
                .navigationTitle("Coffees") // Title name
                .navigationBarTitleDisplayMode(.inline) // change title views on the screen
               

            }
            .tabItem {
                Image(systemName: "house.fill")
            }
            //To go OrderView
            OrderView()
                    .tabItem {
                        Image(systemName: "cart.fill")
                    }
            //To go ProfileView
            Profileview()
                .tabItem {
                    Image(systemName:"person.circle.fill")
                }
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
