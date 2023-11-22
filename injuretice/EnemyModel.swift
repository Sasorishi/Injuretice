//
//  EnemyModel.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

class Enemy: ObservableObject {
    @Published var name: String
    @Published var level: Int
    @Published var health: Int
    @Published var skills: [Skill]
    
    init(name: String, level: Int, health: Int, skills: [Skill]) {
        self.name = name
        self.level = level
        self.health = health
        self.skills = skills
    }

    func scaleHealth() {
        health += (level/100)
    }
}
