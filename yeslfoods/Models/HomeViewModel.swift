//
//  HomeViewModel.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var recommended: [FoodItem] = []
    @Published var topOrdered: [FoodItem] = []
    @Published var spotlight: [FoodItem] = []
    
    init() {
        loadSampleData()
    }
    
    func loadSampleData() {
        // In real app load from API / DB. For assignment use local arrays.
        self.recommended = recommendedItems
        self.topOrdered = topOrderedItems
        self.spotlight = spotlightItems
    }
    
    func sections(for category: String) -> [(String, [FoodItem])] {
        let key = category.lowercased()

        switch key {
        case "pizza":
            let allPizza = (recommended + topOrdered + spotlight).filter {
                if let c = $0.category { return c.lowercased() == "pizza" }
                return $0.name.lowercased().contains("pizza")
            }

            let veg = allPizza.filter { ($0.subCategory?.lowercased().contains("veg") ?? false) || $0.name.lowercased().contains("veg") || $0.name.lowercased().contains("paneer") || $0.name.lowercased().contains("corn") }
            let nonveg = allPizza.filter { ($0.subCategory?.lowercased().contains("non") ?? false) || $0.name.lowercased().contains("chicken") || $0.name.lowercased().contains("tandoori") || $0.name.lowercased().contains("peri") }

            let remaining = allPizza.filter { !veg.contains($0) && !nonveg.contains($0) }
            let vegFinal = veg + remaining.filter { !$0.name.lowercased().contains("chicken") } // heuristics
            let nonvegFinal = nonveg + remaining.filter { $0.name.lowercased().contains("chicken") }

            return [("Pizza Veg", vegFinal), ("Pizza Non-Veg", nonvegFinal)]
        case "pasta":
            let pastaItems = (recommended + topOrdered + spotlight).filter { $0.name.lowercased().contains("pasta") }
            return [("Popular Pastas", pastaItems)]

        case "ice cream", "icecream", "ice-cream":
            let ice = (recommended + spotlight + topOrdered).filter { name in
                let n = name.name.lowercased()
                return n.contains("ice") || n.contains("milkshake") || n.contains("shake")
            }
            return [("Ice Creams", ice)]

        case "cool drinks", "cooldrinks", "drinks", "beverages":
            let drinks = (recommended + spotlight + topOrdered).filter { name in
                let n = name.name.lowercased()
                return n.contains("drink") || n.contains("coke") || n.contains("sprite") || n.contains("cola")
            }
            return [("Cool Drinks", drinks)]

        case "snacks":
            let veg = recommended.filter { $0.name.lowercased().contains("snack") || $0.name.lowercased().contains("nacho") }
            let nonveg = topOrdered.filter { $0.name.lowercased().contains("chicken") }
            return [("Sides Veg", veg), ("Sides Non-Veg", nonveg)]

        default:
            let combined = recommended + topOrdered + spotlight
            return [("All", combined)]
        }
    }
}
