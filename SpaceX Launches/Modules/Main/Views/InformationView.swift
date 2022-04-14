//
//  InformationView.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 5.04.22.
//

import UIKit

protocol InformationViewDelegate {
    func watchLaunches()
    func openSettings()
}

class InformationView: UIView {
    
    private var scrollView: UIScrollView!
    private var headerLabel: UILabel!
    private var headerView: UIView!
    private var settingButton: UIButton!
    private var informationCollectionView: UICollectionView!
    private var infoLabel: InfoStageView!
    private var firstStageLabel: InfoStageView!
    private var secondStageLabel: InfoStageView!
    private var imageView: UIImageView!
    private var backgroundView: UIView!
    private var watchButton: UIButton!
    
    var model: SpaceRocketModel?
    var delegate: InformationViewDelegate?
    var metterings: [Item]!
    
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
        
        guard let model = model else { return }

        let cost_per_launch = String(model.cost_per_launch ?? 0)
        
        infoLabel.setText(label1Text: ("Первый запуск", getFormattedDate(model.first_flight ?? "")),
                                label2Text: ("Страна", (model.country ?? "")),
                                label3Text: ("Стоймость запуска", "\(cost_per_launch)"))
        
        guard let first_stage = model.first_stage else { return }
        let engines = String(first_stage.engines ?? 0)
        let fuel_amount_tons = String(first_stage.fuel_amount_tons ?? 0.0)
        let burn_time_sec = String(first_stage.burn_time_sec ?? 0)
        
        firstStageLabel.setTitle(title: "ПЕРВАЯ СТУПЕНЬ")
        firstStageLabel.setText(label1Text: ("Количество двигателей", engines),
                                label2Text: ("Количество топлива", fuel_amount_tons),
                                label3Text: ("Время сгорания", burn_time_sec))
        
        guard let second_stage = model.second_stage else { return }
        let engines2 = String(second_stage.engines ?? 0)
        let fuel_amount_tons2 = String(second_stage.fuel_amount_tons ?? 0.0)
        let burn_time_sec2 = String(second_stage.burn_time_sec ?? 0)
        
        secondStageLabel.setTitle(title: "ВТОРАЯ СТУПЕНЬ")
        secondStageLabel.setText(label1Text: ("Количество двигателей", engines2),
                                 label2Text: ("Количество топлива", fuel_amount_tons2),
                                 label3Text: ("Время сгорания", burn_time_sec2))
        
    }
   
    func setMettering(isHeightM: Bool, isWidthM: Bool, isMassKg: Bool, isPayloadKg: Bool) {
        guard let model = model else { return }
        guard let height = model.height else { return }
        (informationCollectionView.visibleCells[0] as! InfoCollectionViewCell).addData(value: isHeightM ? String(height.meters!) : String(height.feet!) , title: "Высота, \(isHeightM ? "m" : "ft")")
        
        guard let diameter = model.diameter else { return }
        (informationCollectionView.visibleCells[1] as! InfoCollectionViewCell).addData(value: isWidthM ? String(diameter.meters!) : String(diameter.feet!) , title: "Диаметр, \(isWidthM ? "m" : "ft")")
        
        guard let mass = model.mass else { return }
        (informationCollectionView.visibleCells[2] as! InfoCollectionViewCell).addData(value: isMassKg ? String(mass.kg!) : String(mass.lb!) , title: "Масса, \(isMassKg ? "kg" : "lb")")
        
        guard let payload_weights = model.payload_weights!.first else { return }
        (informationCollectionView.visibleCells[3] as! InfoCollectionViewCell).addData(value: isPayloadKg ? String(payload_weights.kg!) : String(payload_weights.lb!) , title: "Нагрузка, \(isPayloadKg ? "kg" : "lb")")
    }
    
    private func getFormattedDate(_ string: String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM, yyyy"
        dateFormatterPrint.locale = Locale(identifier: "ru_RUS")

        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date ?? Date() );
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
        
        settingButton = UIButton()
        settingButton.setImage(UIImage(named: "setting"), for: .normal)
        settingButton.addTarget(self, action: #selector(settingAction), for: .touchUpInside)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .black
        headerView.addSubview(headerLabel)
        headerView.addSubview(settingButton)
        headerView.layer.cornerRadius = 32
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 48),
            headerLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 32),
            headerLabel.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -32),
            headerLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -82),
            
            settingButton.topAnchor.constraint(equalTo: headerLabel.topAnchor),
            settingButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -35),
            settingButton.widthAnchor.constraint(equalToConstant: 32),
            settingButton.heightAnchor.constraint(equalToConstant: 32),
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
        delegate?.watchLaunches()
    }
    
    @objc func settingAction() {
        delegate?.openSettings()
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
        
        guard let metteringItem = metterings.first else { return cell }
        guard let height = model.height else { return cell}
        guard let diameter = model.diameter else { return cell}
        guard let mass = model.mass else { return cell}
        guard let payload_weights = model.payload_weights!.first else { return cell}

        switch indexPath.row {
        case 0:
            cell.addData(value: !metteringItem.mH ? String(height.meters!) : String(height.feet!) ,title: "Высота, \(!metteringItem.mH ? "m" : "ft")")
        case 1:
            cell.addData(value: !metteringItem.mW ? String(diameter.meters!) : String(diameter.feet!) ,title: "Диаметр, \(!metteringItem.mW ? "m" : "ft")")
        case 2:
            cell.addData(value: !metteringItem.kgM ? String(mass.kg!) : String(mass.lb!) , title: "Масса, \(!metteringItem.kgM ? "kg" : "lb")")
        case 3:
            cell.addData(value: !metteringItem.kgP ? String(payload_weights.kg!) : String(payload_weights.lb!) ,title: "Нагрузка, \(!metteringItem.kgP ? "kg" : "lb")")
        default:
            break
        }
        
        return cell
    }
}
