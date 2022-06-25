//
//  ViewModel.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 24.06.2022.
//

import Foundation

protocol viewModelDelegate: AnyObject{
    func dataModel(data: [RickAndMortyQuery.Data.Character.Result])
}

class viewModel {
    var characterData = [RickAndMortyQuery.Data.Character.Result]()
    
    weak var delegate: viewModelDelegate?
    
    func loadData() {
        
            Network.shared.apollo.fetch(query: RickAndMortyQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    if let results = graphQLResult.data?.characters?.results{
                        self.characterData =  results.compactMap { $0 }
                        self.delegate?.dataModel(data: self.characterData)
                    }
                case .failure(let error):
                    print("Failure! Error: \(error)")
                }
            }
        }
}
