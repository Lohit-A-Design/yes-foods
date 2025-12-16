//
//  MainTabView.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//
import SwiftUI
import Combine

//final class TabRouter: ObservableObject {
//    static let shared = TabRouter()
//    @Published var selected: Int = 0
//    private init() {}
//}

struct MainTabView: View {
    @StateObject private var cart = CartManager.shared
    @EnvironmentObject private var router: TabRouter

    var body: some View {
        TabView(selection: $router.selected) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(AppTab.home)
                .toolbarBackground(Color("BrandBlue"), for: .tabBar)
                .toolbar(.visible, for: .tabBar)

            CategoriesView()
                .tabItem { Label("Categories", systemImage: "square.grid.2x2") }
                .tag(AppTab.categories)
                .toolbarBackground(Color("BrandBlue"), for: .tabBar)
                .toolbar(.visible, for: .tabBar)

            CartView()
                .tabItem { Label("Cart", systemImage: "cart.fill") }
                .tag(AppTab.cart)
                .badge(cart.items.count)
                .toolbarBackground(Color("BrandBlue"), for: .tabBar)
                .toolbar(.visible, for: .tabBar)

            AccountView()
                .tabItem { Label("My Account", systemImage: "person.fill") }
                .tag(AppTab.account)
                .toolbarBackground(Color("BrandBlue"), for: .tabBar)
                .toolbar(.visible, for: .tabBar)
        }
        .tint(.blue) // selected icon/text color
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(TabRouter())          
                       .environmentObject(CartManager.shared)
    }
}
