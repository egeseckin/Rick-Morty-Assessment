//
//  ViewModel.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 24.06.2022.
//

import Foundation

class viewModel {
    private(set) var characterData = [RickAndMortyQuery.Data.Character.Result]()
    private var page: Int = 1
    private var totalPage: Int = 0
    private var oldName: String?
    var dataTaken: (([RickAndMortyQuery.Data.Character.Result], Int, Int) -> Void)?

    func loadData(name: String?) {
        if oldName != name {
            oldName = name
            characterData = []
            page = 1
        }
        Network.shared.apollo.fetch(query: RickAndMortyQuery(page: page, name: name ?? "")) { [self] result in
            switch result {
            case .success(let graphQLResult):
                if let info = graphQLResult.data?.characters?.info {
                    if let pageNumber = info.pages {
                        self.totalPage = pageNumber
                        if  self.page <= pageNumber {
                            self.page += 1
                        } else {
                            break
                        }
                    }
                }
                if let results = graphQLResult.data?.characters?.results {
                    self.characterData.append(contentsOf: results.compactMap { $0 })
                    self.dataTaken?(self.characterData, self.page, self.totalPage)
                }
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
