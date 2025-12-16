//  HomeView.swift
//  yeslfoods
//  Created by Lohit on 04/12/25.

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @StateObject private var cart = CartManager.shared
    @State private var badgeCount: Int = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    HeaderView(badgeCount: badgeCount)
                    LocationBarView()
                    CategoryGridView()
                    PromoBannerView()
                    FoodSectionView(title: "Recommended", items: vm.recommended, addAction: addToCart)
                        .padding(.bottom, 14)

                    FoodSectionView(title: "Top Food Ordered", items: vm.topOrdered, addAction: addToCart)
                        .padding(.bottom, 14)

                    FoodSectionView(title: "In the Spotlight", items: vm.spotlight, addAction: addToCart)
                    Spacer(minLength: 60) // space above tab bar
                }
                .padding(.vertical)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationBarHidden(true)
        }
        .environmentObject(vm)
        .onAppear {
            badgeCount = Int.random(in: 1...50)
        }
    }

    private func addToCart(_ item: FoodItem) {
        cart.add(item)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
