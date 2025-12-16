//
//  yeslfoodsApp.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//


import SwiftUI

@main
struct yeslfoodsApp: App {
    @StateObject private var router = TabRouter()
    @StateObject private var vm = HomeViewModel()               
    @StateObject private var notificationManager = NotificationManager.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
                .environmentObject(vm)
                .environmentObject(notificationManager)
        }
    }
}
//let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBlue
//
//        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white.withAlphaComponent(0.6)
//        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
//
//        UITabBar.appearance().standardAppearance = appearance
//        if #available(iOS 15.0, *) {
//            UITabBar.appearance().scrollEdgeAppearance = appearance
//        }
