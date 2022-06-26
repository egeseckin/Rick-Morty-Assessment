//
//  filterView.swift
//  Rick-Morty-Assessment
//
//  Created by Ege Seçkin on 25.06.2022.
//

import UIKit

protocol filterViewDelegate: AnyObject {
    func didRickSelected()
    func didMortySelected()
}

class filterView: UIView {

    private var background = UIView()
    private let filter = UIView()
    private let lblTitle = UILabel()
    private let seperatorView = UIView()
    private let lblRick = UILabel()
    private let imgRick = UIImageView()
    private let rickStackView = UIStackView()
    private let lblMorty = UILabel()
    private let imgMorty = UIImageView()
    private let mortyStackView = UIStackView()
    private var rickSelected: Bool?
    private var mortySelected: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    weak var delegate: filterViewDelegate?

    init(frame: CGRect, rickSelected: Bool?, mortySelected: Bool?) {
        super.init(frame: frame)
        self.rickSelected = rickSelected
        self.mortySelected = mortySelected
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        // Background view to made it darker
        background = UIView(frame: self.bounds)
        background.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.7)
        self.addSubview(background)
        background.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissTapped))
        background.addGestureRecognizer(tap)

        filterSetup()

    }
    @objc private func dismissTapped() {
        self.removeFromSuperview()
    }
}

private extension filterView {
    private func filterSetup() {

        background.addSubview(filter)
        filter.addSubview(lblTitle)
        filter.addSubview(seperatorView)
        filter.addSubview(rickStackView)
        filter.addSubview(mortyStackView)

        // filter View
        filter.backgroundColor = .white
        filter.layer.cornerRadius = 10.0
        filter.snp.makeConstraints { (make) in
            make.height.equalTo(164)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-25)
            make.centerY.equalToSuperview()
        }

        // Title View
        lblTitle.text = "Filter"
        lblTitle.font = UIFont(name: "Roboto-Bold", size: 24.0)
        lblTitle.snp.makeConstraints {(make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        // Seperator View
        seperatorView.backgroundColor =  #colorLiteral(red: 0.5741509199, green: 0.5741508603, blue: 0.5741509199, alpha: 1) // colorLiteral
        seperatorView.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(8)
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
        }

        rickViewAdjustments()
        mortyViewAdjustments()

        if rickSelected ?? false {
            imgRick.image = UIImage(named: "imgSelected")
            imgMorty.image = UIImage(named: "imgNotSelected")
        } else if mortySelected ?? false {
            imgRick.image = UIImage(named: "imgNotSelected")
            imgMorty.image = UIImage(named: "imgSelected")
        } else {
            imgRick.image = UIImage(named: "imgNotSelected")
            imgMorty.image = UIImage(named: "imgNotSelected")
        }
    }
}

// MARK: Buttons tapped
private extension filterView {
    @objc private func rickTapped() {
        delegate?.didRickSelected()
        self.removeFromSuperview()
    }

    @objc private func mortyTapped() {
        delegate?.didMortySelected()
        self.removeFromSuperview()
    }
}

// MARK: Label Adjustments
private extension filterView {
    private func rickViewAdjustments() {
        // Rick Label
        lblRick.text = "Rick"
        lblRick.font = UIFont(name: "Roboto-Regular", size: 24.0)
        rickStackView.addArrangedSubview(lblRick)
        rickStackView.addArrangedSubview(imgRick)
        imgRick.snp.makeConstraints {(make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        rickStackView.alignment = .fill
        rickStackView.distribution = .equalCentering
        rickStackView.isUserInteractionEnabled = true
        rickStackView.snp.makeConstraints { (make) in
            make.top.equalTo(seperatorView).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        let tapRickGesture = UITapGestureRecognizer(target: self, action: #selector(rickTapped))
        rickStackView.addGestureRecognizer(tapRickGesture)
    }

    // Morty Label
    private func mortyViewAdjustments() {
        lblMorty.text = "Morty"
        lblMorty.font = UIFont(name: "Roboto-Regular", size: 24.0)
        mortyStackView.addArrangedSubview(lblMorty)
        mortyStackView.addArrangedSubview(imgMorty)
        imgMorty.snp.makeConstraints {(make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        mortyStackView.alignment = .fill
        mortyStackView.distribution = .equalCentering
        mortyStackView.isUserInteractionEnabled = true
        mortyStackView.snp.makeConstraints { (make) in
            make.top.equalTo(rickStackView.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        let tapMortyGesture = UITapGestureRecognizer(target: self, action: #selector(mortyTapped))
        mortyStackView.addGestureRecognizer(tapMortyGesture)
    }
}
