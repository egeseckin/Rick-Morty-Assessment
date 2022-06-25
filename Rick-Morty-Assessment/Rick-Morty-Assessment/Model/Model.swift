//
//  Model.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 24.06.2022.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let id: String
    let name: String
    let origin: Location
    let image: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
