//
//  PlayerDetailView.swift
//  injuretice
//
//  Created by Alban On on 23/11/2023.
//

import SwiftUI

struct PlayerDetailView: View {
    @Binding var player: Character?

    var body: some View {
        VStack {
            Text("Player Details")
                .font(.title)

            if let player = player {
                Text("Name: \(player.name)")
                Text("Age: \(player.age)")
                Text("Job: \(player.job)")
            } else {
                Text("No player details available.")
            }

            Spacer()
        }
        .padding()
    }
}
