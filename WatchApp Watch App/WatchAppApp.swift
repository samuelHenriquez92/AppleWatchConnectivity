//
//  WatchAppApp.swift
//  WatchApp Watch App
//
//  Created by Samuel Henriquez on 6/20/23.
//

import SwiftUI

@main
struct WatchApp_Watch_AppApp: App {
    @WKApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
