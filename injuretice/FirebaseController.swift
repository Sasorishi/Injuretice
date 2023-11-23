//
//  FirebaseController.swift
//  injuretice
//
//  Created by Alban On on 23/11/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

func addPlayerToFirestore(_ player: Character) {
    let db = Firestore.firestore()
    let playersCollection = db.collection("players")

    do {
        // Convert player object to dictionary
        let playerData: [String: Any] = [
            "appareance": player.appareance,
            "name": player.name,
            "age": player.age,
            "job": player.job,
            "skills": player.skills.map { skill in
                return [
                    "name": skill.name,
                    "damage": skill.damage,
//                    "type": skill.type
                ]
            },
//            "color": player.color.hexString // Convert Color to hex string
        ]

        try playersCollection.addDocument(data: playerData)

    } catch let error {
        print("Error adding player to Firestore: \(error.localizedDescription)")
    }
}

extension Color {
    func hexString() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return "000000" // Return black for invalid color
        }

        let red = UInt8(components[0] * 255.0)
        let green = UInt8(components[1] * 255.0)
        let blue = UInt8(components[2] * 255.0)

        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
