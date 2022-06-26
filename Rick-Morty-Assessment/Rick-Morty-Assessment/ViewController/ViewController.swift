//
//  ViewController.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 24.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    fileprivate var hideBackground: UIView?

    private let lblTitle = UILabel()
    private let tableView = UITableView()
    private let filterButton = UIButton()

    private var characterCount = 0
    private var rickSelected = false
    private var mortySelected = false

    lazy var model = {
        viewModel()
    }()

    var data = [RickAndMortyQuery.Data.Character.Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        model.loadData(name: "")
        setupUI()
    }

    private func setupUI() {

        view.addSubview(lblTitle)
        view.addSubview(filterButton)
        view.addSubview(tableView)

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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(customTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.allowsSelection = false
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottomMargin).offset(22)
            make.leading.equalToSuperview().offset(19) // +5 goes to shadow in cell
            make.trailing.equalToSuperview().offset(-19) // +5 goes to shadow in cell
            make.bottom.equalToSuperview()
        }
        model.dataTaken = { [weak self] data in
            self?.data = data
            self?.tableView.reloadData()
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
        model.loadData(name: "rick")
        tableView.setContentOffset(.zero, animated: false)
    }
    func didMortySelected() {
        rickSelected = false
        mortySelected = true
        model.loadData(name: "morty")
        tableView.setContentOffset(.zero, animated: false)
    }
}

// MARK: tableView adjustments
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! customTableViewCell
        cell.setupCell(data: data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 281.0 // +16 for empty view inside cell for spacing tableview
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offSetY > contentHeight - height * 1.8 {
            if rickSelected {
                self.model.loadData(name: "rick")
            } else if mortySelected {
                self.model.loadData(name: "morty")
            } else {
                self.model.loadData(name: "")
            }
        }
    }
}
