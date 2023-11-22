//
//  BattleController.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

func generateRandomEnemy(maxLevel: Int) async -> Enemy {
    var randomName: String = ""

    do {
        let randomUserResponse = try await fetchRandomName()
        if let firstUser = randomUserResponse.results.first {
            randomName = "\(firstUser.name.first) \(firstUser.name.last)"
//            print(randomName)
        } else {
            print("Failed to fetch random name.")
        }
    } catch {
        print("Error fetching random name: \(error)")
    }
    
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
