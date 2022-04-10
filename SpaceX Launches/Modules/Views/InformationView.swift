//
//  InformationView.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import UIKit

protocol InformationViewDelegate {
    func watchLaunches(_ rocket: String)
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
        
        firstStageLabel.setTitle(title: "ПЕРВАЯ СТУПЕНЬ")
        firstStageLabel.setText(label1Text: ("Количество двигателей", "\(model?.first_stage?.engines)"),
                                label2Text: ("Количество топлива", "\(model?.first_stage?.fuel_amount_tons)"),
                                label3Text: ("Время сгорания", "\(model?.first_stage?.burn_time_sec)"))
        
        secondStageLabel.setTitle(title: "ВТОРАЯ СТУПЕНЬ")
        secondStageLabel.setText(label1Text: ("Количество двигателей", "\(model?.second_stage?.engines)"),
                                 label2Text: ("Количество топлива", "\(model?.second_stage?.fuel_amount_tons)"),
                                 label3Text: ("Время сгорания", "\(model?.second_stage?.burn_time_sec)"))
        
    }
    
    private func loadImage() {
        if let imageUrl = URL(string: model?.flickr_images?.first ?? "") {
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
        headerLabel.font = .boldSystemFont(ofSize: 32.0)
        headerLabel.textColor = .init(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .black
        headerView.addSubview(headerLabel)
        headerView.layer.cornerRadius = 32
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 48),
            headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32),
            headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -82),
        ])
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 96, height: 96)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 12
        informationCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        informationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        informationCollectionView.showsHorizontalScrollIndicator = false
        informationCollectionView.backgroundColor = .black
        informationCollectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.reuseIdentifier)
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
        watchButton.layer.cornerRadius = 12

        self.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        scrollView.addSubview(headerView)
        scrollView.addSubview(informationCollectionView)
        scrollView.addSubview(infoLabel)
        scrollView.addSubview(firstStageLabel)
        scrollView.addSubview(secondStageLabel)
        scrollView.addSubview(watchButton)
        
        // configure constraints
        let topImageViewConstrain = self.topAnchor.constraint(equalTo: imageView.topAnchor)
        topImageViewConstrain.priority = .init(rawValue: 900)
        
        NSLayoutConstraint.activate([
            
            topImageViewConstrain,
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: self.frame.size.height / 3.5),
            headerView.leftAnchor.constraint(equalTo: self.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: self.rightAnchor),
            headerView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -32),
            
            informationCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -50),
            informationCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            informationCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            informationCollectionView.heightAnchor.constraint(equalToConstant: 96),
            
            infoLabel.topAnchor.constraint(equalTo: informationCollectionView.bottomAnchor, constant: 32),
            infoLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            infoLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            
            firstStageLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32),
            firstStageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            firstStageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            
            secondStageLabel.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 32),
            secondStageLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 32),
            secondStageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            
            watchButton.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 32),
            watchButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            watchButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            watchButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -64),
            watchButton.heightAnchor.constraint(equalToConstant: 56),
            
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
            backgroundView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
        ])
        
    }
    
    @objc func watchNow() {
        delegate?.watchLaunches(model!.id!)
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
        let cell = informationCollectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.reuseIdentifier, for: indexPath) as! InfoCollectionViewCell
        
        cell.backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        cell.layer.cornerRadius = 32
        
        guard let model = model else { return cell }

        switch indexPath.row {
        case 0:
            cell.addData(value: "\(model.height!.meters!)", title: "Высота, m")
        case 1:
            cell.addData(value: "\(model.diameter!.meters!)", title: "Диаметр, m")
        case 2:
            cell.addData(value: "\(model.mass!.kg!)", title: "Масса, kg")
        case 3:
            cell.addData(value: "\(model.payload_weights![0].kg!)", title: "Нагрузка, kg")
        default:
            break
        }
        
        return cell
    }
}
