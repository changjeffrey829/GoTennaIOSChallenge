//
//  DetailLocationCell.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

class DetailLocationCell: UITableViewCell {
    
    var viewModel: DetailLocationViewModel? {
        didSet {
            guard let vm = viewModel else {return}
            nameLabel.attributedText = vm.nameAttributedString()
            descriptLabel.attributedText = vm.descriptAttributedString()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "name"
        return label
    }()
    
    let descriptLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

