//
//  InfoCollectionViewCell.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 8.04.22.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
   
    static let reuseIdentifier = "info-reuse-identifier"
    private let valueLabel = UILabel()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func addData(value: String, title: String) {
        valueLabel.text = value
        titleLabel.text = title
    }
    
}

extension InfoCollectionViewCell {
    func configure() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(valueLabel)
        contentView.addSubview(titleLabel)

        valueLabel.textAlignment = .center
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.textColor = .white
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.textColor = .init(red: 142/255, green: 142/255, blue: 143/255, alpha: 1)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
            ])
    }
}
