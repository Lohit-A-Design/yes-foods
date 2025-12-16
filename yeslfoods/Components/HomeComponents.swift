//
//  HomeComponents.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import SwiftUI
import Combine


struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.size.width
        let h = rect.size.height

        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w/2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        path.closeSubpath()
        return path
    }
}
//struct H_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView()
//    }
//}
struct HeaderView: View {
    var badgeCount: Int = 0
    var userInitials: String = "RT"
    var logoAssetName: String = "YeslLogo"
    var headerHeight: CGFloat = 70

    var showSearch: Bool = true
    var showBell: Bool = true
    var showProfile: Bool = true

    var onSearch: () -> Void = {}
    var onBellTap: () -> Void = {}
    var onProfileTap: () -> Void = {}

    var trailingContent: AnyView? = nil

    var body: some View {
        ZStack {
            Color(red: 1.0, green: 136/255, blue: 6/255)

            HStack(spacing: 2) {
                HStack {
                    if Image(uiImageNamed: logoAssetName) != nil {
                        Image(logoAssetName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 28)
                            .padding(.leading, 10)
                            .accessibilityHidden(true)
                    }
                    Spacer(minLength: 0)
                }
                .frame(height: headerHeight - 2)
                .padding(.leading, 0)
                .background(
                    RoundedCorners(tl: 0,
                                   tr: (headerHeight - 2) / 2,
                                   bl: 0,
                                   br: (headerHeight - 2) / 2)
                        .fill(Color.white)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                .frame(width: 150, alignment: .leading)

                Spacer()

                if showSearch {
                    Button(action: onSearch) {
                        Circle()
                            .fill(Color.clear)
                            .frame(width: 34, height: 34)
                            .overlay(
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 24, weight: .regular))
                                    .foregroundColor(.white)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Search")
                }

                if showBell {
                    Button(action: onBellTap) {
                        ZStack(alignment: .topTrailing) {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 34, height: 34)
                                .overlay(
                                    Image(systemName: "bell")
                                        .font(.system(size: 24, weight: .regular))
                                        .foregroundColor(.white)
                                )

                            if badgeCount > 0 {
                                Text("\(badgeCount)")
                                    .font(.system(size: 7, weight: .bold))
                                    .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))
                                    .frame(width: 12, height: 12)
                                    .background(Circle().fill(Color.white))
                                    .offset(x: -4, y: 4)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Notifications")
                }

                if showProfile {
                    Button(action: onProfileTap) {
                        Circle()
                            .fill(Color(red: 0/255, green: 81/255, blue: 183/255))
                            .frame(width: 35, height: 35)
                            .overlay(Text(userInitials).foregroundColor(.white).bold())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Account")
                }

                if let trailing = trailingContent {
                    trailing
                        .padding(.trailing, 6)
                }
            }
            .padding(.leading, 0)
            .padding(.trailing, 12)
            .padding(.vertical, 1)
        }
        .frame(height: headerHeight)
    }
}

fileprivate func Image(uiImageNamed name: String) -> Image? {
    #if canImport(UIKit)
    if UIImage(named: name) != nil { return Image(name) }
    #else
    return Image(name)
    #endif
    return nil
}

struct LocationBarView: View {
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: "location")
                    .font(.system(size: 15))
                    .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Text("Hyderabad, Telangana")
                            .font(.system(size: 10, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .semibold))
                    }

                    Text("Plot.no.69, Road No 3, KVR Valley, Mallampet,...")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "building.2.fill")
                        .font(.system(size: 15))
                        .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))

                    HStack(spacing: 6) {
                        Text("Mallampet")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.primary)
                        Image(systemName: "chevron.down")
                            .font(.system(size: 8, weight: .semibold))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(0)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color(red: 0/255, green: 81/255, blue: 183/255).opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.03), radius: 1, x: 0, y: 1)
        .padding(.horizontal, 0)
        .padding(.top, 1)
    }
}
func addToCart(_ item: FoodItem) {
    CartManager.shared.add(item)
}

struct CategoryGridView: View {
    let categories: [(String,String)] = [
        ("Pizza", "pizza_img"),
        ("Ice Cream", "icecream_img"),
        ("Pasta", "pasta_img"),
        ("Snacks", "snacks_img"),
        ("Milk shakes", "milkshake_img"),
        ("Cool Drinks", "cooldrinks_img")
    ]
    @EnvironmentObject private var router: TabRouter
    @EnvironmentObject private var vm: HomeViewModel
    var showSeeMore: Bool = true

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(categories, id: \.0) { c in
                    NavigationLink(destination:
                        SubCategoryView(
                            categoryTitle: c.0,
                            sections: vm.sections(for: c.0),
                            addAction: { item in addToCart(item) }
                        )
                        .environmentObject(vm)
                    ) {
                        VStack(spacing: 10) {
                            Image(c.1)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 90, height: 90)
                                .clipShape(RoundedRectangle(cornerRadius: 20))

                            Text(c.0)
                                .font(.custom("Poppins-Regular", size: 12))
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 0)
            .padding(.top, 15)

            if showSeeMore {
                Button(action: { router.selected = .categories }) {
                    Text("See more")
                        .font(.custom("Poppins-Regular", size: 10))
                        .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 36)
                .buttonStyle(.plain)
                .accessibilityLabel("See more categories")
            }
        }
    }
}

struct PromoBannerView: View {
    let banners = ["banner1", "banner2", "banner3"]
    @State private var currentIndex = 0
    @State private var isUserDragging = false

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<banners.count, id: \.self) { index in
                Button(action: {
                    print("Tapped banner \(index)")
                }) {
                    Image(banners[index])
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .buttonStyle(.plain)
                .tag(index)
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .onChanged { _ in
                            if !isUserDragging { isUserDragging = true }
                        }
                        .onEnded { _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                isUserDragging = false
                            }
                        }
                )
            }
        }
        .frame(height: 200)
        .padding(.bottom, 20)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onReceive(Timer.publish(every: 3, on: .main, in: .common).autoconnect()) { _ in
            guard !isUserDragging else { return }
            withAnimation(.easeInOut(duration: 0.35)) {
                currentIndex = (currentIndex + 1) % banners.count
            }
        }
    }
}

struct FoodSectionView: View {
    var title: String
    var items: [FoodItem]
    var addAction: (FoodItem) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(Color(red: 0/255, green: 81/255, blue: 183/255))
                .padding(.horizontal)
                .padding(.bottom, 4)
            ForEach(items) { item in
                FoodCardView(item: item, addAction: addAction)
            }
        }
    }
}
struct FoodCardView: View {
    var item: FoodItem
    var addAction: (FoodItem) -> Void = { _ in }

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(.custom("Poppins-SemiBold", size: 14))
                    .foregroundColor(.primary)

                Text("₹ \(item.price)/-")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundColor(.primary)

                Text(item.description)
                    .font(.custom("Poppins-Regular", size: 10))
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }

            Spacer()

            VStack(spacing: 4) {
                ZStack(alignment: .bottom) {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 80)
                        .cornerRadius(12)
                    Button(action: {
                        addAction(item)
                    }) {
                        Text("Add +")
                                .font(.custom("Poppins-Medium", size: 12))
                                .foregroundColor(.white)
                                .frame(width: 70, height: 23)
                                .background(Color(red: 0/255, green: 81/255, blue: 183/255))
                                .cornerRadius(12)
                    }
                    .offset(y: 12)
                }
                .padding(.bottom, 12)

                if item.isCustomizable {
                    Text("Customizable")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 110)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 2))
        .padding(.horizontal)
    }
}
