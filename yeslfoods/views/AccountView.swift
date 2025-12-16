import SwiftUI

//
//  AccountView.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

struct AccountView: View {
    @State private var name: String = "Lohit Narayan"
    @State private var email: String = "lohitallavarapu@gmail.com"

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // Profile header
                HStack(alignment: .center, spacing: 12) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 64, height: 64)
                        .overlay(
                            Text(String(name.prefix(1)))
                                .font(.title2)
                                .foregroundColor(.white)
                        )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.title2)
                            .bold()
                        Text(email)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding()

                List {
                    Section {
                        NavigationLink(value: "orders") {
                            Label("My Orders", systemImage: "bag")
                        }
                        NavigationLink(value: "favorites") {
                            Label("Favorites", systemImage: "heart")
                        }
                        NavigationLink(value: "addresses") {
                            Label("Addresses", systemImage: "map.pin")
                        }
                    }

                    Section {
                        NavigationLink(value: "settings") {
                            Label("Settings", systemImage: "gear")
                        }

                        Button(action: {
                            // logout action
                            print("Logout tapped")
                        }) {
                            Label("Logout", systemImage: "arrow.backward.square")
                                .foregroundColor(.red)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("My Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
