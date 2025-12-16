//
//  CartManager.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import Foundation
import Combine

final class CartManager: ObservableObject {
    static let shared = CartManager()
    @Published private(set) var items: [FoodItem] = []
    
    private init() {}
    
    func add(_ item: FoodItem) {
        items.append(item)
        print("Cart now has \(items.count) items")
    }
    
    func remove(_ item: FoodItem) {
        items.removeAll { $0 == item }
    }
    
    func clear() {
        items.removeAll()
    }
}
