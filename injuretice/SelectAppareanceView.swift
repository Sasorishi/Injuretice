//
//  SelectAppareanceView.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

struct SelectAppareance: View {
    let images: [String]
    @Binding var selectedIndex: Int

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
            .onChange(of: selectedIndex) { newIndex in
                print("Selected index changed to \(newIndex)")
                selectedIndex = newIndex
            }
        }
    
    func getSelectedValue() -> String {
        return images[selectedIndex]
    }
}
