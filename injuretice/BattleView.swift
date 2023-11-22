//
//  BattleView.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

func spawnEnemy(maxLevel: Int) -> Enemy {
    let randomEnemy = generateRandomEnemy(maxLevel: maxLevel)
    return randomEnemy
}

func battle(enemyHealth: Int, playerHealth: Int) -> Bool {
    if (enemyHealth <= 0 || playerHealth <= 0) {
        return false
    }
    return true
}

struct BattleView: View {
    @Binding var player: Character?
    let enemy: Enemy
    @State private var enemyCurrentHealth: Int
    @State private var playerCurrentHealth: Int
    @State private var isBattleOver: Bool = false
    @State private var combatLog: String = ""

    init(player: Binding<Character?>) {
        self._player = player
        self.enemy = spawnEnemy(maxLevel: 20)
        _enemyCurrentHealth = State(initialValue: enemy.health)
        _playerCurrentHealth = State(initialValue: player.wrappedValue? .health ?? 0)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Ennemi")
                    Text("\(enemy.name) - niveau \(enemy.level)")
                }
                HStack {
                    Text("Point de vie")
                    Text("\(enemyCurrentHealth) / \(enemy.health)")
                }

                Spacer()

                HStack {
                    Text("\(player?.name ?? "Inconnu") - niveau \(player?.level ?? 0)")
                }
                HStack {
                    Text("Point de vie")
                    Text("\(playerCurrentHealth) / \(player?.health ?? 0)")
                }
                
                Section {
                    VStack {
                        List(player?.skills ?? []) { skill in
                            Button(action: {
                                // Logique pour exécuter la compétence ici
                                performSkill(skill)
                            }) {
                                HStack {
                                    Text(skill.name)
                                    Spacer()
                                    Text("Dégâts: \(skill.damage)")
                                }
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(10)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }

                // Animation d'attaque
                // ...

                // Barres de santé
                // ...

                // Texte d'état
                Text(combatLog)
                    .padding()
                    .foregroundColor(.black)

                // Options de fuite
                // ...
            }
        }
        .onAppear {
            // Logique d'initialisation du combat
            combatLog += " ---- Combat commencé ! ---- \n\n"
        }
        .onChange(of: enemyCurrentHealth) { _ in
            // Logique pour vérifier si le combat doit continuer
            if !battle(enemyHealth: enemyCurrentHealth, playerHealth: playerCurrentHealth) {
                combatLog += "---- Combat terminé ! ---- \n\n"
                isBattleOver = true
            }
        }
    }
    
    private func performSkill(_ skill: Skill) {
        enemyCurrentHealth -= skill.damage
        combatLog += "\(player?.name ?? "Inconnu") utilise \(skill.name) et inflige \(skill.damage) dégâts à \(enemy.name). \n"
        combatLog += "\(enemy.name) a maintenant \(enemyCurrentHealth) / \(enemy.health) points de vie.\n\n"
    }
}
