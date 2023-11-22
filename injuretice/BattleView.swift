//
//  BattleView.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

func spawnEnemy(maxLevel: Int) async -> Enemy {
    let enemy = await generateRandomEnemy(maxLevel: maxLevel)
    print(enemy.name)
    return enemy
}

func battle(enemyHealth: Int, playerHealth: Int) -> Bool {
    if (enemyHealth <= 0 || playerHealth <= 0) {
        return false
    }
    return true
}

struct BattleView: View {
    @Binding var player: Character?

    @State private var enemyCurrentHealth: Int
    @State private var playerCurrentHealth: Int
    @State private var isBattleOver: Bool = false
    @State private var combatLog: String = ""
    
    @State private var enemy: Enemy?

    init(player: Binding<Character?>) {
        self._player = player
        self._enemyCurrentHealth = State(initialValue: 0)
        self._playerCurrentHealth = State(initialValue: player.wrappedValue?.health ?? 0)
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Ennemi")
                    Text("\(enemy?.name ?? "Unknown") - niveau \(enemy?.level ?? 0)")
                }
                HStack {
                    Text("Point de vie")
                    Text("\(enemyCurrentHealth) / \(enemy?.health ?? 0)")
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
                
                Section(header: Text("Combat log")) {
                    ScrollView {
                        VStack {
                            Text(combatLog)
                                .padding()
                                .foregroundColor(.black)
                        }
                        .padding(12)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(red: 211 / 255, green: 217 / 255, blue: 212 / 255))
                    }
                }
                
                // Options de fuite
                // ...
            }
        }
        .onAppear {
            Task {
                do {
                    self.enemy = try await generateRandomEnemy(maxLevel: 20)
                    self.enemyCurrentHealth = self.enemy?.health ?? 0
                    self.playerCurrentHealth = self.player?.health ?? 0
                } catch {
                    print("Error generating enemy: \(error)")
                }
            }
            combatLog += " ---- Combat commencé ! ---- \n\n"
        }
        .onChange(of: enemyCurrentHealth) { _ in
            if !battle(enemyHealth: enemyCurrentHealth, playerHealth: playerCurrentHealth) {
                combatLog += "---- Combat terminé ! ---- \n\n"
                isBattleOver = true
            }
        }
    }
    
    private func performSkill(_ skill: Skill) {
        enemyCurrentHealth -= skill.damage
        combatLog += "\(player?.name ?? "Inconnu") utilise \(skill.name) et inflige \(skill.damage) dégâts à \(enemy?.name). \n"
        combatLog += "\(enemy?.name) a maintenant \(enemyCurrentHealth) / \(enemy?.health) points de vie.\n\n"
    }
}
