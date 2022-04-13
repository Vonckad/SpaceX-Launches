//
//  MyTripleLabel.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 7.04.22.
//

import Foundation
import UIKit

class MyTripleLabel: UIView {
    
    private let leftLabel1 = UILabel()
    private let rightLabel1 = UILabel()
    private let metteringLabel1 = UILabel()
    private var rightMetteringLabelAnchor: NSLayoutConstraint!
    
    var textColor: UIColor? {
        didSet {
            leftLabel1.textColor = textColor
            rightLabel1.textColor = .white
            metteringLabel1.textColor = textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(leftLabel1)
        self.addSubview(rightLabel1)
        self.addSubview(metteringLabel1)
        
        leftLabel1.translatesAutoresizingMaskIntoConstraints = false
        rightLabel1.translatesAutoresizingMaskIntoConstraints = false
        metteringLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        rightLabel1.textAlignment = .right
        rightLabel1.font = .boldSystemFont(ofSize: 16)
        rightLabel1.adjustsFontSizeToFitWidth = true
    }
    
    func setText(leftText: String, rightText: String, metteringText: String? = nil) {
        leftLabel1.text = leftText
        rightLabel1.text = rightText
        metteringLabel1.text = metteringText
        setConstraints(isMetteringText: metteringText != nil)
        
        if metteringText == "#" {
            metteringLabel1.text = ""
            rightMetteringLabelAnchor.constant = -24
        }
    }
    
    private func setConstraints(isMetteringText: Bool) {
        rightMetteringLabelAnchor = metteringLabel1.rightAnchor.constraint(equalTo: self.rightAnchor)
        
        NSLayoutConstraint.activate([
            leftLabel1.topAnchor.constraint(equalTo: self.topAnchor),
            leftLabel1.leftAnchor.constraint(equalTo: self.leftAnchor),
            leftLabel1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            rightLabel1.topAnchor.constraint(equalTo: self.topAnchor),
            rightLabel1.leftAnchor.constraint(greaterThanOrEqualTo: leftLabel1.rightAnchor) ,
            rightLabel1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            metteringLabel1.topAnchor.constraint(equalTo: self.topAnchor),
            metteringLabel1.leftAnchor.constraint(equalTo: rightLabel1.rightAnchor, constant: isMetteringText ? 8 : 0),
            metteringLabel1.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            rightMetteringLabelAnchor
//            metteringLabel1.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
