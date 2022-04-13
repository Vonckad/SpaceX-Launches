//
//  InfoStageView.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 7.04.22.
//

import Foundation
import UIKit

class InfoStageView: UIView {
    
    private var label1 = MyTripleLabel()
    private var label2 = MyTripleLabel()
    private var label3 = MyTripleLabel()
    private var titleLabel: UILabel?
    private var topAnchorLabel1: NSLayoutConstraint!
    
    var space: CGFloat
    
    init(frame: CGRect, space: CGFloat) {
        self.space = space
        super.init(frame: frame)
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
    
        topAnchorLabel1 = label1.topAnchor.constraint(equalTo: self.topAnchor)
        
        NSLayoutConstraint.activate([
            topAnchorLabel1,
            label1.leftAnchor.constraint(equalTo: self.leftAnchor),
            label1.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: space),
            label2.leftAnchor.constraint(equalTo: self.leftAnchor),
            label2.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: space),
            label3.leftAnchor.constraint(equalTo: self.leftAnchor),
            label3.rightAnchor.constraint(equalTo: self.rightAnchor),
            label3.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setTitle(title: String) {
        titleLabel = UILabel()
        guard let titleLabel = titleLabel else { return }
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = .boldSystemFont(ofSize: 24.0)
        titleLabel.textColor = .init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        topAnchorLabel1.isActive = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            label1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func setText(label1Text: (String, String), label2Text: (String, String), label3Text: (String, String)) {
        
        label1.setText(leftText: label1Text.0,
                       rightText: label1Text.1,
                       metteringText: (self.topAnchorLabel1.isActive == false) ? "#" : nil)
        
        label2.setText(leftText: label2Text.0,
                       rightText: label2Text.1,
                       metteringText: (self.topAnchorLabel1.isActive == false) ? "ton" : nil)
        
        label3.setText(leftText: label3Text.0,
                       rightText: label3Text.1,
                       metteringText: (self.topAnchorLabel1.isActive == false) ? "sec" : nil)
    }
    
    func setTextColor(_ color: UIColor) {
        label1.textColor = color
        label2.textColor = color
        label3.textColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
