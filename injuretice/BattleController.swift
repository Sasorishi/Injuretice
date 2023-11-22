//
//  BattleController.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

func generateRandomEnemy(maxLevel: Int) -> Enemy {
    let names = ["Goblin", "Orc", "Skeleton", "Spider", "Troll", "Dragon"]
    let randomName = names.randomElement() ?? "Unknown Enemy"

    let randomLevel = Int.random(in: 1...maxLevel)

    let randomSkills: [Skill] = (0..<3).map { index in
        let skillName = "Skill \(index + 1)"
        let skillDamage = Int.random(in: 5...20)
        let isAttack = Bool.random()
        let skillType: Skill.SkillType = isAttack ? .attack : .defense
        return Skill(name: skillName, damage: skillDamage, type: skillType)
    }

    return Enemy(name: randomName, level: randomLevel, health: randomLevel, skills: randomSkills)
}
