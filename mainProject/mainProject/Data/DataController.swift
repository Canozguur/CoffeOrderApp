//
//  DataController.swift
//  mainProject
//
//  Created by Can Özgür on 21.05.2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "CoffeeM")
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Data saved successfully.")
            } catch {
                print("Failed to save data: \(error)")
            }
        }
    }
    
    func addOrder(name: String, price: Double, size: String) {
        let context = container.viewContext
        let coffee = Coffee(context: context)
        coffee.id = UUID()
        coffee.date = Date()
        coffee.name = name
        coffee.price = price
        coffee.size = size
        
        save()
    }
    
    func editUser(profile : Profile, adresLine1: String, adresLine2: String, city: String, country: String) {
        _ = container.viewContext
        profile.city = city
        profile.country = country
        profile.adresline1 = adresLine1
        profile.adresline2 = adresLine2
        save()
    }
    func addUser(adresLine1: String, adresLine2: String, city: String, country: String) {
        let context = container.viewContext
        let profile = Profile(context: context)
        profile.id = UUID()
        profile.city = city
        profile.country = country
        profile.adresline1 = adresLine1
        profile.adresline2 = adresLine2

        save()
    }
}
