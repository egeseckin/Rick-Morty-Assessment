//
//  dataParseTest.swift
//  Rick-Morty-AssessmentTests
//
//  Created by Ege Seçkin on 26.06.2022.
//

import XCTest
@testable import Rick_Morty_Assessment

class dataParseTest: XCTestCase {

    func testCanParseCharacter() {
        let characterData = RickAndMortyQuery.Data.Character.Result(id: "1",
                                                                    name: "Rick Sanchez",
                                                                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                                                    location: RickAndMortyQuery.Data.Character.Result.Location(name: "Citadel of Ricks"))

        Network.shared.apollo.fetch(query: RickAndMortyQuery(page: 1, name: "")) { result in

            switch result {

            case .success(let graphQLResult):
                if let response = graphQLResult.data?.characters?.results {
                    XCTAssertEqual(characterData.id, response[0]?.id)
                }

            case .failure(let error):
                XCTFail("Failure! Error: \(error)")
            }
        }
    }
}
