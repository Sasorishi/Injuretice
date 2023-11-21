//
//  ContentView.swift
//  injuretice
//
//  Created by Alban On on 20/11/2023.
//

import SwiftUI

func createCharacter(appareance: String, username: String, age: Int, jobname: String, skills: [Skill], color: Color) -> Character {
    let player = Character(appareance: appareance, name: username, age: age, job: jobname, skills: skills, color: color)
    print(player)
    return player
}

struct ContentView: View {
    let imageNames = ["girl-1", "boy-1", "boy-2", "boy-3", "boy-4"]

    @State private var appareance: String = ""
    @State private var username: String = ""
    @State private var age: Int = 0
    @State private var jobname: String = ""
    @State private var selectedColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var isShowingSkillCreationView = false
    @State private var characterSkills: [Skill] = []
    @State private var player: Character?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Apparence du personnage").font(.headline).textCase(nil)
                    .multilineTextAlignment(.center)) {
                    SelectAppareance(images: imageNames)
                        .frame(height: 150).background(selectedColor)
                }
                
                Section(header: Text("Informations").font(.headline).textCase(nil)
                    .multilineTextAlignment(.center)) {
                    TextField("Entre ton nom", text: $username)
                    Stepper(value: $age, in: 1...50) {
                        Text("Age : \(age)")
                    }
                    TextField("Entre ta classe", text: $jobname)
                    ColorPicker("Choisi ta couleur", selection: $selectedColor)
                        .labelsHidden()
                }
                
                Section {
                    NavigationLink(destination: SkillCreationView(skills:  $characterSkills)) {
                        Text("Créer une compétence")
                    }
                }
                
                Section {
                    NavigationLink(destination: BattleView(player: $player)) {
                        Button("Combattre") {
                            appareance = SelectAppareance(images: imageNames).getSelectedValue()
                            player = createCharacter(appareance: appareance, username: username, age: age, jobname: jobname, skills: characterSkills, color: selectedColor)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.black)
                    }
                }
            }
            .background(Color(red: 110, green: 143, blue: 195))
            .navigationBarTitle("Création de personnage", displayMode: .inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
