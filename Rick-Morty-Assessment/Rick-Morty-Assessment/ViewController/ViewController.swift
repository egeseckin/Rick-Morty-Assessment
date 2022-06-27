//
//  ViewController.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 24.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let lblTitle = UILabel()
    private let tableView = tableViewforItems()
    private let filterButton = UIButton()

    private(set) var rickSelected = false
    private(set) var mortySelected = false

    private var model = viewModel()
    private var data = [RickAndMortyQuery.Data.Character.Result]()
    private var currentPage = 0
    private var totalPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        filterData(filter: 0) // Fetch all characters data
        setupUI()
    }

    private func setupUI() {

        view.addSubview(lblTitle)
        view.addSubview(filterButton)
        view.addSubview(tableView)
        tableView.delegate = self

        // title view adjustments
        lblTitle.textAlignment = .center
        lblTitle.text = "Rick and Morty"
        lblTitle.font = UIFont(name: "Roboto-Bold", size: 24.0)

        lblTitle.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(28)
            m.centerX.equalToSuperview()
        }

        // for sort button adjustments
        let filterImage = UIImage(named: "imgFilter")
        filterButton.setImage(filterImage, for: .normal)
        filterButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterTapped))
        filterButton.addGestureRecognizer(tapGesture)

        filterButton.snp.makeConstraints { (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(26)
            m.trailing.equalToSuperview().offset(-24)
        }

        // for tableview adjustments
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottomMargin).offset(22)
            make.leading.equalToSuperview().offset(19) // +5 goes to shadow in cell
            make.trailing.equalToSuperview().offset(-19) // +5 goes to shadow in cell
            make.bottom.equalToSuperview()
        }

        model.dataTaken = { [weak self] data, currentPage, totalPage in
            self?.currentPage = currentPage
            self?.totalPage = totalPage
            self?.data = data
            self?.tableView.dataTaken(data: self?.data, rickSelected: self?.rickSelected, mortySelected: self?.mortySelected, currentPage: self?.currentPage, totalPage: self?.totalPage)
        }
    }
}

extension ViewController: tableViewforItemsDelegate {
    func filterItem(filter: Int?) {
        if filter == 1 {
            filterData(filter: 1)
        } else if filter == 2 {
            filterData(filter: 2)
        } else {
            filterData(filter: 0)
        }
    }
}

private extension ViewController {
    @objc private func filterTapped() {
        let filterView = filterView.init(frame: self.view.bounds, rickSelected: self.rickSelected, mortySelected: self.mortySelected)
        view.addSubview(filterView)
        filterView.delegate = self
    }
}

// MARK: Filter Delegate
extension ViewController: filterViewDelegate {
    func didRickSelected() {
        rickSelected = true
        mortySelected = false
        filterData(filter: 1)
        tableView.goToTop()
    }
    func didMortySelected() {
        rickSelected = false
        mortySelected = true
        filterData(filter: 2)
        tableView.goToTop()
    }
}

private extension ViewController {
    private func filterData(filter: Int?) {
        if filter == 1 {
            self.model.loadData(name: "rick")
        } else if filter == 2 {
            self.model.loadData(name: "morty")
        } else {
            self.model.loadData(name: "")
        }
    }
}
