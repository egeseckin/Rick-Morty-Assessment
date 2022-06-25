//
//  Apollo.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 25.06.2022.
//

import Foundation
import Apollo

class Network {
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
}
