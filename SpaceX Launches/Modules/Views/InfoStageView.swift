//
//  InfoStageView.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 7.04.22.
//

import Foundation
import UIKit

class InfoStageView: UIView {
    
    private var label1: MyDoubleLabel = MyDoubleLabel()
    private var label2: MyDoubleLabel = MyDoubleLabel()
    private var label3: MyDoubleLabel = MyDoubleLabel()
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
    
        NSLayoutConstraint.activate([
            label1.topAnchor.constraint(equalTo: self.topAnchor),
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
    
    func setText(label1Text: (String, String), label2Text: (String, String), label3Text: (String, String)) {
        label1.setText(leftText: label1Text.0, rightText: label1Text.1)
        label2.setText(leftText: label2Text.0, rightText: label2Text.1)
        label3.setText(leftText: label3Text.0, rightText: label3Text.1)
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
