//
//  WatchSessionManager.swift
//  AppleWatchConnect
//
//  Created by Samuel Henriquez on 6/19/23.
//

import SwiftUI
import WatchConnectivity

final class WatchSessionManager: NSObject, ObservableObject {

    // MARK: - Singleton

    static var shared = WatchSessionManager()

    private override init() {
        super.init()
    }

    // MARK: - Variables Definition

    @Published var message = "Not received :("

    private var counter = 0
    private var session: WCSession?

    var isReachable: Bool {
        session?.isReachable ?? false
    }
    var colorStatus: Color {
        guard let state = session?.activationState else { return .red }
        switch state {
        case .notActivated:
            return .red
        case .inactive:
            return .orange
        case .activated:
            return .green
        @unknown default:
            return .gray
        }
    }

    // MARK: - Public Methods

    func activate() {
        session = WCSession.default
        session?.delegate = self
        session?.activate()
    }

    func sendMessage(with message: [String: Any]) {
        session?.sendMessage(
            message,
            replyHandler: { reply in
                print(reply)
            },
            errorHandler: { error in
                print(error.localizedDescription)
            }
        )
    }
}

extension WatchSessionManager: WCSessionDelegate {

    // MARK: - WCSessionDelegate Implementation

    // Handle message reception from the Watch
    func session(
        _ session: WCSession,
        didReceiveMessage message: [String: Any],
        replyHandler: @escaping ([String: Any]) -> Void
    ) {
        guard let message = message["message"] as? String else { return }

        // Update the counter
        counter += 1

        DispatchQueue.main.sync { [weak self] in
            self?.message = message + " for \(self?.counter ?? .zero) times"
        }
    }

    // Handle data transfer from the Watch
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {}

    // Handle file transfer from the Watch
    func session(_ session: WCSession, didReceive file: WCSessionFile) {}

    func sessionReachabilityDidChange(_ session: WCSession) {}

    /// Called when an app context is received.
    ///
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {}

    /// WCSessionDelegate methods for iOS only.
    ///
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
        return
    }

    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }

    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif

    func session(
        _ session: WCSession,
        activationDidCompleteWith activationState: WCSessionActivationState,
        error: Error?
    ) {
        switch activationState {
        case .notActivated:
            print("-- not activated")
        case .inactive:
            print("-- inactive")
        case .activated:
            print("-- activated")
        @unknown default:
            return
        }
    }
}
