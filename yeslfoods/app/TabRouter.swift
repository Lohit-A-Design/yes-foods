//
//  TabRouter.swift
//  yeslfoods
//
//  Created by Lohit on 08/12/25.
//

import SwiftUI
import Combine

enum AppTab: Hashable {
    case home, categories, cart, account
}

final class TabRouter: ObservableObject {
    @Published var selected: AppTab = .home
}
