//
//  SkillCreationView.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

struct SkillCreationView: View {
    @Binding var skills: [Skill]
    @State private var skillName = ""
    @State private var skillDamage = 0
    @State private var selectedSkillType: Skill.SkillType = .attack
    
    var body: some View {
        Form {
            Section(header:
                        Text("Création de compétence")
                .font(.headline)
                .textCase(nil)
                .multilineTextAlignment(.center)
            ) {
                VStack(alignment: .center) {
                    VStack {
                        Picker("Type de compétence", selection: $selectedSkillType) {
                            Text("Attaque").tag(Skill.SkillType.attack)
                            Text("Défense").tag(Skill.SkillType.defense)
                        }
                    }
                    
                    .pickerStyle(SegmentedPickerStyle())
                    
                    TextField("Nom de la compétence", text: $skillName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Stepper(value: $skillDamage, in: 0...100) {
                        Text("\(selectedSkillType == .attack ? "Dégâts : " : "Défense : ") \(skillDamage)")
                    }
                    
                    Button("Ajouter la compétence") {
                        let newSkill = Skill(name: skillName, damage: skillDamage, type: selectedSkillType)
                        skills.append(newSkill)

                        skillName = ""
                        skillDamage = 0
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            
            Section(header: Text("Compétences")) {
                ForEach(skills.indices, id: \.self) { index in
                    HStack {
                        if skills[index].type == .attack {
                            Image("sword")
                            .resizable()
                            .frame(width: 15, height: 15)
                        } else {
                            Image("shield")
                            .resizable()
                            .frame(width: 15, height: 15)
                        }
                        
                        Text("\(skills[index].name) - \(skills[index].type == .attack ? "Dégâts" : "Défense") : \(skills[index].damage)")

                        Button("Supprimer") {
                            skills.remove(at: index)
                        }
                        .foregroundColor(Color.red)
                    }
                    .padding()
                }
            }
        }
        .background(Color(red: 255, green: 255, blue: 255))
        .navigationBarTitle("Création de compétence", displayMode: .inline)
    }
}
