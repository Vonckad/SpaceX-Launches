//
//  MyDoubleLabel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 7.04.22.
//

import Foundation
import UIKit

class MyDoubleLabel: UIView {
    
    private var leftLabel1 = UILabel()
    private var rightLabel1 = UILabel()
    private var stackView = UIStackView()
    
    var textColor: UIColor? {
        didSet {
            leftLabel1.textColor = textColor
            rightLabel1.textColor = textColor
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        stackView.addArrangedSubview(leftLabel1)
        stackView.addArrangedSubview(rightLabel1)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        leftLabel1.setContentHuggingPriority(.init(rawValue: 250), for: .horizontal)
        rightLabel1.setContentHuggingPriority(.init(rawValue: 251), for: .horizontal)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
//        stackView.spacing = 6
    }
    
    func setText(leftText: String, rightText: String) {
        leftLabel1.text = leftText
        rightLabel1.text = rightText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
