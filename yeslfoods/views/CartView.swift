//
//  CartView.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var cart = CartManager.shared

    var body: some View {
        NavigationStack {
            VStack {
                if cart.items.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "cart")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                        Text("Your cart is empty")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                } else {
                    List {
                        ForEach(cart.items) { item in
                            HStack {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 50)
                                    .cornerRadius(8)
                                    .clipped()

                                VStack(alignment: .leading) {
                                    Text(item.name).font(.headline)
                                    Text("₹ \(item.price)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()

                                Button {
                                    cart.remove(item)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .listStyle(.insetGrouped)

                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("₹ \(cart.items.reduce(0) { $0 + $1.price })")
                            .font(.headline)
                    }
                    .padding()
                }
            }
            .navigationTitle("Cart")
        }
    }
}
