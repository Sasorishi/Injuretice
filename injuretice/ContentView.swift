//
//  ContentView.swift
//  injuretice
//
//  Created by Alban On on 20/11/2023.
//

import SwiftUI

struct Character {
    let appareance: String
    let name: String
    let age: Int
    let job: String
    let health: Int = 100
    let level: Int = 0
    let experience: Double = 0.0
    let skills: [String]
    let color: Color
}

struct Skill: Identifiable {
    let id = UUID()
    let name: String
    let damage: Int
}

struct SelectAppareance: View {
    let images: [String] // Remplacez [String] par le type de vos images
    @State private var selectedIndex = 0

    var body: some View {
            TabView(selection: $selectedIndex) {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            print("Image \(images[index]) cliquée !")
                            selectedIndex = index
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    
    func getSelectedValue() -> String {
        return images[selectedIndex]
    }
}

func createCharacter(appareance: String, username: String, age: Int, jobname: String, skills: [String], color: Color) {
    let character = Character(appareance: appareance, name: username, age: age, job: jobname, skills: skills, color: color)
    return print(character)
}

struct BattleView : View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
            }
        }
    }
}

struct ContentView: View {
    let imageNames = ["girl-1", "boy-1", "boy-2", "boy-3", "boy-4"]
    let skills = [
        Skill(name: "Fils de p***", damage: 10),
        Skill(name: "Con****", damage: 20),
        Skill(name: "Lance flamme", damage: 50),
    ]
    
    @State private var appareance: String = ""
    @State private var username: String = ""
    @State private var age: Int = 0
    @State private var jobname: String = ""
    @State private var selectedSkills: [String] = []
    @State private var selectedColor: Color = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)
    
    var body: some View {
        NavigationView {
            VStack {
                VStack{
                    Text("Création de personnage")
                    SelectAppareance(images: imageNames)
                        .frame(height: 150)
                }.background(selectedColor)
                HStack {
                    Text("Entre ton nom : ")
                    TextField("Jean Bernard", text: $username)
                        .padding()
                        .background()
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("Entre ton age : ")
                    TextField("", value: $age, formatter: NumberFormatter())
                        .frame(width: 50)
                    Stepper(value: $age, in: 1...50) {
                        EmptyView()
                    }
                }
                HStack {
                    Text("Entre ta classe : ")
                    TextField("B2A", text: $jobname)
                        .padding()
                        .background()
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                }
                HStack {
                    Text("Entre ta couleur : ")
                    ColorPicker("Choisi ta couleur", selection: $selectedColor)
                        .labelsHidden()
                        .frame(width: .infinity, height: 10)
                }
                VStack {
                    Text("Choisir tes sorts : ")
                    List(skills) { skill in
                        Button(action: {
                            if selectedSkills.contains(skill.name) {
                                selectedSkills.removeAll(where: { $0 == skill.name })
                            } else {
                                selectedSkills.append(skill.name)
                            }
                        }) {
                            Text("\(skill.name) - \(skill.damage) de dégat")
                                .foregroundColor(selectedSkills.contains(skill.name) ? .red : .primary)
                        }
                        .onTapGesture {
                            if selectedSkills.contains(skill.name) {
                                selectedSkills.removeAll(where: { $0 == skill.name })
                            } else {
                                selectedSkills.append(skill.name)
                            }
                        }
                    }
                }
                NavigationLink(destination: BattleView()) {
                    Button("Valider") {
                        appareance = SelectAppareance(images: imageNames).getSelectedValue()
                        print(appareance)
                        createCharacter(appareance: appareance, username: username, age: age, jobname: jobname, skills: selectedSkills, color: selectedColor)
                    }
                    .frame(width: .infinity)
                    .foregroundColor(Color.black)
                    .buttonStyle(.bordered).background(Color(red: 110, green: 143, blue: 195))
                }
            }.background(Color(red: 255, green: 255, blue: 255))
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
