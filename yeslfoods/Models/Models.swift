//
//  Models.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import Foundation

struct FoodItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let price: Int
    let description: String
    let imageName: String
    let isCustomizable: Bool
    let category: String? = nil
    let subCategory: String? = nil
}

let recommendedItems: [FoodItem] = [
    FoodItem(name: "Boiled Egg Pizza", price: 700, description: "Cheese, Boiled Eggs", imageName: "image1", isCustomizable: true),
    FoodItem(name: "Pineapple Pizza", price: 500, description: "Pineapple, Olives", imageName: "image2", isCustomizable: true),
    FoodItem(name: "Chicken Pasta", price: 500, description: "Chicken, Olives", imageName: "image3", isCustomizable: true),
    FoodItem(name: "Paneer Pizza", price: 450, description: "Paneer, Capsicum", imageName: "image1", isCustomizable: true),

    FoodItem(
        name: "Chicken Tandoori Pizza",
        price: 500,
        description: "Tandoori chicken, cheese",
        imageName: "image2",
        isCustomizable: true
    ),

    FoodItem(
        name: "Corn & Jalapeno Pizza",
        price: 420,
        description: "Sweet corn, jalapeno, cheese",
        imageName: "image3",
        isCustomizable: true
    )
]

let topOrderedItems: [FoodItem] = [
    FoodItem(name: "Mango Delight", price: 219, description: "Cheese, Boiled Eggs", imageName: "image2", isCustomizable: true),
    FoodItem(name: "Peri-Peri Chicken Pasta", price: 500, description: "Pineapple, Olives", imageName: "image1", isCustomizable: true),
    FoodItem(name: "French Fries", price: 100, description: "Crispy, Golden Fries", imageName: "image3", isCustomizable: true)
]

let spotlightItems: [FoodItem] = [
    FoodItem(name: "Mint Chocolate Chip Milkshake", price: 169, description: "Mint, Chocolate", imageName: "image3", isCustomizable: true),
    FoodItem(name: "Tandoori Chicken Pasta", price: 500, description: "Spicy, Smoky", imageName: "image1", isCustomizable: true),
    FoodItem(name: "Litchi Delight Small", price: 100, description: "Fresh Litchi, Cream", imageName: "image2", isCustomizable: true)
]
