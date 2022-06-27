//
//  MockGraphQLQuery.swift
//  Rick-Morty-AssessmentTests
//
//  Created by Ege Seçkin on 26.06.2022.
//

import Foundation

enum MockGraphQLQuery{
    
    typealias JSONObject = [String: Any]
    
    case characters
    
    var responseString: String {
        switch self {
        case .characters:
            return MockGraphQLQuery.characterResponseString
            
        }
    }
    
    var responseObject: JSONObject? {
        
        guard
            let data = responseString.data(using: .utf8),
            let object = try? JSONSerialization.jsonObject(with: data, options: []) as? JSONObject
        else { return nil }
        return object
    }
    
    private static let characterResponseString =
    """
    {
        "data": {
            "characters": {
                "info": {
                    "count": 826,
                    "pages": 42
                },
                "results": [
                    {
                        "id": "1",
                        "name": "Rick Sanchez",
                        "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                        "origin": {
                            "name": "Earth (C-137)"
                        }
                    }
                    
                ]
            }
        }
    }
    """
}
