//
//  AppDelegate.swift
//  WatchApp Watch App
//
//  Created by Samuel Henriquez on 6/20/23.
//

import WatchConnectivity
import WatchKit

class AppDelegate: NSObject, WKApplicationDelegate {
    func applicationDidFinishLaunching() {
        if WCSession.isSupported() {
            WatchSessionManager.shared.activate()
        }
    }
}
