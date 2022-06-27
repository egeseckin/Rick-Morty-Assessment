//
//  dataParseTest.swift
//  Rick-Morty-AssessmentTests
//
//  Created by Ege Seçkin on 26.06.2022.
//

import XCTest
@testable import Rick_Morty_Assessment

class dataParseTest: XCTestCase {
    private var model: tableViewforItems!
    let characterData: [RickAndMortyQuery.Data.Character.Result] = [
        RickAndMortyQuery.Data.Character.Result.init(id: "1", name: "Rick Sanchez", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", location: RickAndMortyQuery.Data.Character.Result.Location( name: "Earth (Replacement Dimension)"))
        ]
    var bundle: Bundle!
    
    override func setUp() {
        bundle = Bundle(for: dataParseTest.self)
    }
    
    func testCanParseCharacter() throws {

    }
}
