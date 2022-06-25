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
    
    let tableView: UITableView = UITableView()
    var characterCount = 0
    
    lazy var model = {
        viewModel()
    }()
    
    var data = [RickAndMortyQuery.Data.Character.Result]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        model.delegate = self
        model.loadData()
        setupUI()
    }
    
    private func setupUI(){
        
        //title view adjustments
        let label: UILabel = {
            let title = UILabel()
            title.textAlignment = .center
            title.text = "Rick and Morty"
            title.font = UIFont(name: "Roboto-Bold", size: 24.0)
            
            return title
        }()
        
        self.view.addSubview(label)
        
        label.snp.makeConstraints{ (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(28)
            m.centerX.equalToSuperview()
        }
        
        //for sort button adjustments
        let filterButton: UIButton = {
            let filter = UIButton()
            let filterImage = UIImage(named: "imgFilter")
            filter.setImage(filterImage, for: .normal)
            filter.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterTapped))
            filter.addGestureRecognizer(tapGesture)
            return filter
        }()
        
        
        self.view.addSubview(filterButton)
        filterButton.snp.makeConstraints{ (m) in
            m.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(26)
            m.trailing.equalToSuperview().offset(-24)
        }
        

        //for tableview adjustments
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(customTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{ (make) in
            make.top.equalTo(label.snp.bottomMargin).offset(22)
            make.leading.equalToSuperview().offset(19) // +5 goes to shadow in cell
            make.trailing.equalToSuperview().offset(-19) // +5 goes to shadow in cell
            make.bottom.equalToSuperview()
        }
    }
}

private extension ViewController {
    @objc private func filterTapped(){
        print("Tapped")
    }
}

extension ViewController: viewModelDelegate {
    func dataModel(data: [RickAndMortyQuery.Data.Character.Result]) {
        self.data = data
        tableView.reloadData()
    }
}

//MARK: tableView adjustments
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSetY > contentHeight - height * 1.75  {
                self.model.loadData()
        }
    }
}



