//
//  SettingsViewController.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 12.04.22.
//

import UIKit

//protocol SettingsViewControllerDelegate {
//    func dismissDetail()
//}

class SettingsViewController: UIViewController {
        
    private var titleLabel: UILabel!
    private var heightLabel: UILabel!
    private var widthLabel: UILabel!
    private var massLabel: UILabel!
    private var payloadLabel: UILabel!
    private var dismissButton: UIButton!
    
    private var heightSegmentedControl: UISegmentedControl!
    private var widthSegmentedControl: UISegmentedControl!
    private var massSegmentedControl: UISegmentedControl!
    private var payloadSegmentedControl: UISegmentedControl!
    
    //constants
    private let whiteColor = UIColor.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    private let grayColor = UIColor.init(red: 142/255, green: 142/255, blue: 143/255, alpha: 1)
    private let attributedString: [NSAttributedString.Key : UIColor] = [.foregroundColor : .black]
    
//    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureLabels()
        configureSegmentedControls()
        setupConstraints()
    }
    
    private func configureLabels() {
    
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = "Настройки"
        view.addSubview(titleLabel)
        
        heightLabel = UILabel()
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.textColor = whiteColor
        heightLabel.text = "Высота"
        view.addSubview(heightLabel)
        
        widthLabel = UILabel()
        widthLabel.translatesAutoresizingMaskIntoConstraints = false
        widthLabel.textColor = whiteColor
        widthLabel.text = "Диаметр"
        view.addSubview(widthLabel)
        
        massLabel = UILabel()
        massLabel.translatesAutoresizingMaskIntoConstraints = false
        massLabel.textColor = whiteColor
        massLabel.text = "Масса"
        view.addSubview(massLabel)
        
        payloadLabel = UILabel()
        payloadLabel.translatesAutoresizingMaskIntoConstraints = false
        payloadLabel.textColor = whiteColor
        payloadLabel.text = "Полезная нагрузка"
        view.addSubview(payloadLabel)
        
        dismissButton = UIButton()
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.setTitle("Закрыть", for: .normal)
        dismissButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissDetailVC), for: .touchUpInside)
        view.addSubview(dismissButton)
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        let spacing = CGFloat(28)
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: guide.topAnchor, constant: 18),
            dismissButton.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: dismissButton.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80),
            heightLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            heightSegmentedControl.centerYAnchor.constraint(equalTo: heightLabel.centerYAnchor),
            heightSegmentedControl.widthAnchor.constraint(equalToConstant: 115),
            heightSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            heightSegmentedControl.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            widthLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 40),
            widthLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            widthSegmentedControl.centerYAnchor.constraint(equalTo: widthLabel.centerYAnchor),
            widthSegmentedControl.widthAnchor.constraint(equalToConstant: 115),
            widthSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            widthSegmentedControl.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
            
            
            massLabel.topAnchor.constraint(equalTo: widthLabel.bottomAnchor, constant: 40),
            massLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            massSegmentedControl.centerYAnchor.constraint(equalTo: massLabel.centerYAnchor),
            massSegmentedControl.widthAnchor.constraint(equalToConstant: 115),
            massSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            massSegmentedControl.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
        
            payloadLabel.topAnchor.constraint(equalTo: massLabel.bottomAnchor, constant: 40),
            payloadLabel.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: spacing),
            payloadLabel.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor),
            payloadSegmentedControl.centerYAnchor.constraint(equalTo: payloadLabel.centerYAnchor),
            payloadSegmentedControl.widthAnchor.constraint(equalToConstant: 115),
            payloadSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            payloadSegmentedControl.rightAnchor.constraint(equalTo: guide.rightAnchor, constant: -spacing),
        ])
    }
    
    private func configureSegmentedControls() {
        heightSegmentedControl = UISegmentedControl(items: ["m", "ft"])
        heightSegmentedControl.selectedSegmentTintColor = .white
        heightSegmentedControl.tintColor = grayColor
        heightSegmentedControl.setTitleTextAttributes(attributedString, for: [.selected])
        heightSegmentedControl.selectedSegmentIndex = 0
        heightSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        heightSegmentedControl.overrideUserInterfaceStyle = .dark
        view.addSubview(heightSegmentedControl)
        
        widthSegmentedControl = UISegmentedControl(items: ["m", "ft"])
        widthSegmentedControl.selectedSegmentTintColor = .white
        widthSegmentedControl.tintColor = grayColor
        widthSegmentedControl.setTitleTextAttributes(attributedString, for: [.selected])
        widthSegmentedControl.selectedSegmentIndex = 0
        widthSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        widthSegmentedControl.overrideUserInterfaceStyle = .dark
        view.addSubview(widthSegmentedControl)
        
        massSegmentedControl = UISegmentedControl(items: ["kg", "lb"])
        massSegmentedControl.selectedSegmentTintColor = .white
        massSegmentedControl.tintColor = grayColor
        massSegmentedControl.setTitleTextAttributes(attributedString, for: [.selected])
        massSegmentedControl.selectedSegmentIndex = 0
        massSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        massSegmentedControl.overrideUserInterfaceStyle = .dark
        view.addSubview(massSegmentedControl)
        
        payloadSegmentedControl = UISegmentedControl(items: ["kg", "lb"])
        payloadSegmentedControl.selectedSegmentTintColor = .white
        payloadSegmentedControl.tintColor = grayColor
        payloadSegmentedControl.setTitleTextAttributes(attributedString, for: [.selected])
        payloadSegmentedControl.selectedSegmentIndex = 0
        payloadSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        payloadSegmentedControl.overrideUserInterfaceStyle = .dark
        view.addSubview(payloadSegmentedControl)
    }
    
    @objc func dismissDetailVC() {
        dismiss(animated: true)
    }
}
