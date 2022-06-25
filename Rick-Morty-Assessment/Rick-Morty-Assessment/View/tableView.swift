//
//  titleView.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 25.06.2022.
//

import UIKit
import SnapKit

class tableViewforItems: UIView{
    
    
    let table: UITableView = {
        let createdTable = UITableView()
        createdTable.translatesAutoresizingMaskIntoConstraints = false
        return createdTable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension tableViewforItems {
   func setupTableView(){
       table.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
       self.addSubview(table)
       table.delegate = self
       table.dataSource = self
    }
}

extension tableViewforItems: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = table.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath) as? customTableViewCell {
            //let image = UIImage(named: "imgFilter")
            //cell.setupCell(image: image)
            return cell
        }
        fatalError("could not dequesReusableCell")
    }
    
    
}
