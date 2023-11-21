//
//  SelectAppareanceView.swift
//  injuretice
//
//  Created by Alban On on 21/11/2023.
//

import SwiftUI

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
