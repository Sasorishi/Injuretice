//
//  StartView.swift
//  injuretice
//
//  Created by Alban On on 23/11/2023.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView {            
            Section {
                VStack {
                    NavigationLink(destination: ContentView()) {
                        VStack {
                            Text("Jouer")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: 140, maxHeight: 80)
                        .background(Color(red: 41/255, green: 86/255, blue: 233/255))
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())

                    NavigationLink(destination: Text("Autre écran")) {
                        VStack {
                            Text("Quitter")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: 140, maxHeight: 80)
                        .background(Color(red: 50/255, green: 71/255, blue: 96/255))
                        .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
