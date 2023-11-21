//
//  CharacterModel.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

struct Character {
    let appareance: String
    let name: String
    let age: Int
    let job: String
    let health: Int = 100
    let level: Int = 1
    let experience: Double = 0.0
    let skills: [Skill]
    let color: Color
}
