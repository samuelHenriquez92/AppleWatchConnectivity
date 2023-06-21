//
//  AppDelegate.swift
//  AppleWatchConnect
//
//  Created by Samuel Henriquez on 6/19/23.
//

import UIKit
import WatchConnectivity

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        if WCSession.isSupported() {
            WatchSessionManager.shared.activate()
        }

        return true
    }
}
