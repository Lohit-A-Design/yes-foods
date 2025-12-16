//
//  ContentView.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .environmentObject(TabRouter())
        .environmentObject(NotificationManager.shared)
        .environmentObject(HomeViewModel())

}

