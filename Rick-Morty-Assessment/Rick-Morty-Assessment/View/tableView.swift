//
//  titleView.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 25.06.2022.
//

import UIKit
import SnapKit

protocol tableViewforItemsDelegate: AnyObject {
    func filterItem(filter: Int?)
}

class tableViewforItems: UIView {

    private let tableView = UITableView()
    private var data = [RickAndMortyQuery.Data.Character.Result]()
    private(set) var rickSelected: Bool?
    private(set) var mortySelected: Bool?
    private(set) var totalPage: Int?
    private(set) var currentPage: Int?

    weak var delegate: tableViewforItemsDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func dataTaken(data: [RickAndMortyQuery.Data.Character.Result]?, rickSelected: Bool?, mortySelected: Bool?, currentPage: Int?, totalPage: Int?) {
        guard let dataTaken = data,
              let filterRick = rickSelected,
              let filterMorty = mortySelected else { return }
        self.data = dataTaken
        self.rickSelected = filterRick
        self.mortySelected = filterMorty
        self.currentPage = currentPage
        self.totalPage = totalPage
        tableView.reloadData()
    }
}
extension tableViewforItems {
    func goToTop() {
        tableView.setContentOffset(.zero, animated: false)
    }
}
private extension tableViewforItems {
   private func setupTableView() {
       tableView.delegate = self
       tableView.dataSource = self
       tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
       tableView.showsVerticalScrollIndicator = false
       tableView.showsHorizontalScrollIndicator = false
       tableView.register(customTableViewCell.self, forCellReuseIdentifier: "customCell")
       tableView.allowsSelection = false

       self.addSubview(tableView)
       tableView.snp.makeConstraints {(make) in
           make.edges.equalToSuperview()
       }
   }
}

// MARK: tableView adjustments
extension tableViewforItems: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customTableViewCell
        let currentData = data[indexPath.row]
        cell.setupCell(data: currentData)

        // Prefetching for infinite scroll
        if currentData.id == (data[data.endIndex-3].id) && (currentPage ?? 0 <= totalPage ?? 0) {
            if rickSelected ?? false {
                delegate?.filterItem(filter: 1)
            } else if mortySelected ?? false {
                delegate?.filterItem(filter: 2)
            } else {
                delegate?.filterItem(filter: 0)            }
        }
        return cell
    }
}
