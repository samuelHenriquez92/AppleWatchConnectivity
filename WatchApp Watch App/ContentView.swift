//
//  ContentView.swift
//  WatchApp Watch App
//
//  Created by Samuel Henriquez on 6/20/23.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Variables Definition

    @State private var text = ""

    // MARK: - View Definition

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(WatchSessionManager.shared.colorStatus)

            Text(text)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)

            Spacer()

            Button {
                sendMessage()
            } label: {
                Text("Send")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onReceive(WatchSessionManager.shared.$message) { newValue in
            text = newValue
        }
    }

    // MARK: - Private Methods

    private func sendMessage() {
        guard WatchSessionManager.shared.isReachable else { return }

        let message = ["message": "We are sending from Watch"]
        WatchSessionManager.shared.sendMessage(with: message)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
