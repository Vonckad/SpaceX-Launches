//
//  InformationView.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import UIKit

protocol InformationViewDelegate {
    func watchLaunches()
}

class InformationView: UIView {
    
    private var scrollView: UIScrollView!
    private var headerLabel: UILabel!
    private var headerView: UIView!
    private var informationCollectionView: UICollectionView!
    private var infoLabel: InfoStageView!
    private var firstStageLabel: InfoStageView!
    private var secondStageLabel: InfoStageView!
    private var imageView: UIImageView!
    private var backgroundView: UIView!
    private var watchButton: UIButton!
    
    var model: SpaceRocketModel?
    var delegate: InformationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applyData() {
        loadImage()
        headerLabel.text = model?.name ?? ""

        infoLabel.setText(label1Text: ("Первый запуск", (model?.first_flight ?? "-")),
                                label2Text: ("Страна", (model?.country ?? "")),
                                label3Text: ("Стоймость запуска", "\(model?.cost_per_launch)"))
        
        firstStageLabel.setText(label1Text: ("Количество двигателей", "\(model?.first_stage?.engines)"),
                                label2Text: ("Количество топлива", "\(model?.first_stage?.fuel_amount_tons)"),
                                label3Text: ("Время сгорания", "\(model?.first_stage?.burn_time_sec)"))
        
        secondStageLabel.setText(label1Text: ("Количество двигателей", "\(model?.second_stage?.engines)"),
                                 label2Text: ("Количество топлива", "\(model?.second_stage?.fuel_amount_tons)"),
                                 label3Text: ("Время сгорания", "\(model?.second_stage?.burn_time_sec)"))
    }
    
    private func loadImage() {
        if let imageUrl = URL(string: model?.flickr_images?.first ?? "") {
            print("imageUrl = \(imageUrl)")
            DispatchQueue.global().async { [weak self] in
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async { [weak self] in
                        self?.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    private func configureUI() {
        self.backgroundColor = .systemBackground
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .black
        
        backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
                
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        infoLabel = InfoStageView(frame: .zero, space: 16)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.setTextColor(.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1))
        infoLabel.backgroundColor = .black
        
        firstStageLabel = InfoStageView(frame: .zero, space: 16)
        firstStageLabel.translatesAutoresizingMaskIntoConstraints = false
        firstStageLabel.setTextColor(.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1))
        firstStageLabel.backgroundColor = .black
        
        secondStageLabel = InfoStageView(frame: .zero, space: 16)
        secondStageLabel.translatesAutoresizingMaskIntoConstraints = false
        secondStageLabel.setTextColor(.init(red: 202/255, green: 202/255, blue: 202/255, alpha: 1))
        secondStageLabel.backgroundColor = .black

        headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.font = .boldSystemFont(ofSize: 40.0)
        headerLabel.textColor = .init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .black//.init(red: 18/255, green: 19/255, blue: 25/255, alpha: 1)
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
            headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32),
            headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -8),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8),
        ])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 96, height: 96)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        informationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        informationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        informationCollectionView.showsHorizontalScrollIndicator = false
        informationCollectionView.backgroundColor = .black
        informationCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        informationCollectionView.dataSource = self
        informationCollectionView.delegate = self
        informationCollectionView.contentInset.left = 32
        informationCollectionView.contentInset.right = 32
        
        watchButton = UIButton()
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        watchButton.setTitle("Посмотреть запуски", for: .normal)
        watchButton.setTitleColor(.init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1), for: .normal)
        watchButton.addTarget(self, action: #selector(watchNow), for: .touchUpInside)
        watchButton.backgroundColor = UIColor.init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        watchButton.layer.cornerRadius = 8

        self.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        scrollView.addSubview(infoLabel)
        scrollView.addSubview(firstStageLabel)
        scrollView.addSubview(secondStageLabel)
        scrollView.addSubview(headerView)
        scrollView.addSubview(informationCollectionView)
        scrollView.addSubview(watchButton)
        
        // configure constraints
        let topImageViewConstrain = self.topAnchor.constraint(equalTo: imageView.topAnchor)
        topImageViewConstrain.priority = .init(rawValue: 900)
        let heightAnchorCastCollectionView = informationCollectionView.heightAnchor.constraint(equalToConstant: 180)
        
        NSLayoutConstraint.activate([
            
            topImageViewConstrain,
            self.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 250),
            headerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            headerView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 24),
            
            informationCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            informationCollectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: informationCollectionView.trailingAnchor),
            heightAnchorCastCollectionView,
            
            infoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32),
            
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            infoLabel.topAnchor.constraint(equalTo: informationCollectionView.bottomAnchor, constant: 8),
            scrollView.bottomAnchor.constraint(equalTo: watchButton.bottomAnchor, constant: 86),
            
            scrollView.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            
            firstStageLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            firstStageLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            scrollView.rightAnchor.constraint(equalTo: firstStageLabel.rightAnchor, constant: 32),
            
            secondStageLabel.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 8),
            secondStageLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            scrollView.rightAnchor.constraint(equalTo: secondStageLabel.rightAnchor, constant: 32),
            
            watchButton.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 500),
            watchButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 64),
            watchButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -64),
            watchButton.heightAnchor.constraint(equalToConstant: 44),
            
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
    }
    
    @objc func watchNow() {
        delegate?.watchLaunches()
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}

extension InformationView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = informationCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        cell.layer.cornerRadius = 32
        return cell
    }
}
