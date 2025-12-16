//
//  NotificationManager.swift
//  yeslfoods
//
//  Created by Lohit on 04/12/25.
//

import Foundation
import Combine

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()

    @Published var unreadCount: Int = 0

    private init() {}

    func set(count: Int) {
        unreadCount = max(0, count)
    }

    func increment(by n: Int = 1) {
        unreadCount += n
    }

    func clear() {
        unreadCount = 0
    }
}
