import SwiftUI

struct CategoriesView: View {
    @StateObject private var cart = CartManager.shared
    @EnvironmentObject var vm: HomeViewModel
    @EnvironmentObject var router: TabRouter
    var showSeeMore: Bool = true
    let categories: [(String,String)] = [
        ("Pizza","pizza_img"),
        ("Ice Cream","icecream_img"),
        ("Pasta","pasta_img"),
        ("Snacks","snacks_img"),
        ("Milk shakes","milkshake_img"),
        ("Cool Drinks","cooldrinks_img")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HeaderView(showSearch: true,
                               showBell: false,
                               showProfile: true,
                    )

                    Text("Categories")
                        .font(.custom("Poppins-Medium", size: 16))
                        .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.top, 8)
                    CategoryGridView(showSeeMore: false)
                        .padding(.horizontal)

                    PromoBannerView()
                        .padding(.top, 4)

                    FoodSectionView(title: "Hot Pizzas", items: vm.recommended, addAction: addToCart)
                        .padding(.bottom, 14)

                    FoodSectionView(title: "Usual Orders", items: vm.topOrdered, addAction: addToCart)
                        .padding(.bottom, 14)

                    FoodSectionView(title: "Best Orders", items: vm.spotlight, addAction: addToCart)
                    Spacer(minLength: 60) // space above tab ba
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    private func addToCart(_ item: FoodItem) {
        cart.add(item)
    }
}
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
            .environmentObject(HomeViewModel())
            .environmentObject(TabRouter())
            .environmentObject(CartManager.shared)
    }
}
