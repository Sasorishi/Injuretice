//
//  EnemyDetailView.swift
//  injuretice
//
//  Created by Alban On on 23/11/2023.
//

import SwiftUI

struct EnemyDetailView: View {
    @Binding var enemy: Enemy?

    var body: some View {
        VStack {
            Text("Enemy Details")
                .font(.title)

            if let enemy = enemy {
                Text("Name: \(enemy.name)")
            } else {
                Text("No enemy details available.")
            }

            Spacer()
        }
        .padding()
    }
}

