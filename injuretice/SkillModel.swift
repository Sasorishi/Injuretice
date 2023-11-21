//
//  SkillModel.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

struct Skill: Identifiable {
    enum SkillType {
        case attack
        case defense
    }
    
    enum SkillElement {
        case fire
        case grass
        case water
        case wind
    }

    let id = UUID()
    let name: String
    let damage: Int
    let type: SkillType
}
