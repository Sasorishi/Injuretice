//
//  ContentView.swift
//  injuretice
//
//  Created by Alban On on 20/11/2023.
//

import SwiftUI

func allParametersFilled(username: String, age: Int, jobname: String) -> Bool {
    return !username.isEmpty && age > 0 && !jobname.isEmpty
}

func createCharacter(appareance: String, username: String, age: Int, jobname: String, skills: [Skill], color: Color) -> Character? {
    let player = Character(appareance: appareance, name: username, age: age, job: jobname, skills: skills, color: color)
    
//    addPlayerToFirestore(player)
    
    print(player)
    return player
}

struct ContentView: View {
    let imageNames = ["girl-1", "boy-1", "boy-2", "boy-3", "boy-4"]

    @State private var appareance: Int = 0
    @State private var username: String = ""
    @State private var age: Int = 0
    @State private var jobname: String = ""
    @State private var selectedColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    @State private var isShowingSkillCreationView = false
    @State private var characterSkills: [Skill] = []
    @State private var player: Character?
    @State private var isNavigationActive: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Apparence du personnage")
                    .padding([.bottom, .trailing], 10)
                    .font(.headline)
                    .textCase(nil)
                    .multilineTextAlignment(.center)) {
                    SelectAppareance(images: imageNames, selectedIndex: $appareance)
                        .listRowInsets(EdgeInsets())
                        .frame(height: 250)
                        .background(selectedColor)
                }
                
                Section(header: Text("Informations")
                    .padding([.bottom, .trailing], 10)
                    .font(.headline)
                    .textCase(nil)
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
                    VStack {
                        Button(action: {
                            if allParametersFilled(username: username, age: age, jobname: jobname) {
                                if let newPlayer = createCharacter(appareance: imageNames[appareance], username: username, age: age, jobname: jobname, skills: characterSkills, color: selectedColor) {
                                    player = newPlayer
                                    print("Player created successfully")
                                    isNavigationActive = true  // Trigger navigation
                                } else {
                                    print("Failed to create a character")
                                }
                            }
                        }) {
                            Text("Combattre")
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .disabled(!allParametersFilled(username: username, age: age, jobname: jobname))
                    .background(
                        NavigationLink(
                            destination: BattleView(player: $player),
                            isActive: $isNavigationActive
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }.background(allParametersFilled(username: username, age: age, jobname: jobname) ? .clear : .gray)
            }
            .background(Color(red: 110, green: 143, blue: 195))
            .navigationBarTitle("Création de personnage", displayMode: .inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
