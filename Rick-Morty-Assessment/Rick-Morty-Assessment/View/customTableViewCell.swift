//
//  customTableViewCell.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 25.06.2022.
//

import UIKit

class customTableViewCell: UITableViewCell{
    
    let image = UIImageView()
    let idStackView = UIStackView()
    let lblIdTitle = UILabel()
    let lblIdValue = UILabel()
    
    let nameStackView = UIStackView()
    let lblNameTitle = UILabel()
    let lblNameValue = UILabel()
    
    let locationStackView = UIStackView()
    let lblLocationTitle = UILabel()
    let lblLocationValue = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        self.layer.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        self.layer.cornerRadius = 10
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.2
        self.layer.shouldRasterize = true
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath

        
        addSubview(image)
        addSubview(idStackView)
        addSubview(nameStackView)
        addSubview(locationStackView)
        
        //Image allignments
        image.clipsToBounds = true
        image.snp.makeConstraints{ (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(168)
        }
        
        //ID allignments
        lblIdTitle.text = "#id: "
        lblIdTitle.font = UIFont(name: "Roboto-Regular", size: 16.0)

        lblIdValue.text = "1"
        lblIdValue.font = UIFont(name: "Roboto-Regular", size: 16.0)
        lblIdValue.textAlignment = .left
        lblIdValue.textColor = #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1) //colorLiteral

        idStackView.addArrangedSubview(lblIdTitle)
        idStackView.addArrangedSubview(lblIdValue)
        idStackView.axis = .horizontal
        idStackView.distribution = .fill
        idStackView.alignment = .fill
        idStackView.spacing = 0
        idStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        //Name Allignments
        lblNameTitle.text = "Name: "
        lblNameTitle.font = UIFont(name: "Roboto-Regular", size: 16.0)

        lblNameValue.text = "Rick Sanchez"
        lblNameValue.font = UIFont(name: "Roboto-Regular", size: 16.0)
        lblNameValue.textAlignment = .left
        lblNameValue.textColor = #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1) //colorLiteral

        nameStackView.addArrangedSubview(lblNameTitle)
        nameStackView.addArrangedSubview(lblNameValue)
        nameStackView.axis = .horizontal
        nameStackView.distribution = .fill
        nameStackView.alignment = .fill
        nameStackView.spacing = 0
        nameStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(idStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(14)
        }

        //Location Allignments
        lblLocationTitle.text = "Location: "
        lblLocationTitle.font = UIFont(name: "Roboto-Regular", size: 16.0)

        lblLocationValue.text = "Earth (Replacement Dimension)"
        lblLocationValue.font = UIFont(name: "Roboto-Regular", size: 16.0)
        lblLocationValue.textAlignment = .left
        lblLocationValue.textColor = #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1) //colorLiteral

        locationStackView.addArrangedSubview(lblLocationTitle)
        locationStackView.addArrangedSubview(lblLocationValue)
        locationStackView.axis = .horizontal
        locationStackView.distribution = .fill
        locationStackView.alignment = .fill
        locationStackView.spacing = 0
        locationStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(nameStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(14)
        }
        
    }
}

extension customTableViewCell {
    func setupCell(){
        
    }
}
