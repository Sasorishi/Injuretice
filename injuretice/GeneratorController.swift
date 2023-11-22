//
//  GeneratorController.swift
//  injuretice
//
//  Created by Alban On on 22/11/2023.
//

import Foundation

func fetchRandomName() async throws -> RandomUserResponse {
    let url = URL(string: "https://randomuser.me/api/")!

    let (data, _) = try await URLSession.shared.data(from: url)
    let decoder = JSONDecoder()
    let randomUserResponse = try decoder.decode(RandomUserResponse.self, from: data)
    return randomUserResponse
}
