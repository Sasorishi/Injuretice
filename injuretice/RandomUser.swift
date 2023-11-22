//
//  RandomUser.swift
//  injuretice
//
//  Created by Alban On on 22/11/2023.
//

struct RandomUserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let name: Name

    struct Name: Codable {
        let first: String
        let last: String
    }
}
