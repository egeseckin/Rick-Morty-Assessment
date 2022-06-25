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
    var page: Int = 1
    
    weak var delegate: viewModelDelegate?
    
    func loadData() {
        
        Network.shared.apollo.fetch(query: RickAndMortyQuery(page: page)) { result in
            switch result {
            case .success(let graphQLResult):
                if let info = graphQLResult.data?.characters?.info{
                    if let pageNumber = info.pages {
                        if  self.page <= pageNumber {
                            self.page += 1
                        }else{
                            break
                        }
                    }
                }
                if let results = graphQLResult.data?.characters?.results{
                    self.characterData.append(contentsOf: results.compactMap { $0 })
                    self.delegate?.dataModel(data: self.characterData)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
