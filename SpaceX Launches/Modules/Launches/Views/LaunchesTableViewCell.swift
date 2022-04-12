//
//  LaunchesTableViewCell.swift
//  SpaceX Launches
//
//  Created by Vlad Ralovich on 11.04.22.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {

    static let reuseIdentifier = "launches-cell-reuse-identifier"
    let view = UIView()
    let myImageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        selectionStyle = .none
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame){
            var frame = newFrame
            frame.origin.x += 32
            frame.size.width -= 2 * 32
            super.frame = frame
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData(title: String, date: String, isSuccess: Bool) {
        titleLabel.text = title// + " " + title
        dateLabel.text = getFormattedDate(date)
        myImageView.image = UIImage(named: isSuccess ? "shuttle" : "shuttle1")
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
}

extension LaunchesTableViewCell {
    private func configure() {
        backgroundColor = .init(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        contentView.clipsToBounds = true
        contentView.addSubview(view)
        view.addSubview(myImageView)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)

        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        dateLabel.textColor = .init(red: 142/255, green: 142/255, blue: 143/255, alpha: 1)
        
        let spacing = CGFloat(24)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacing),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacing),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacing),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacing),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: myImageView.leftAnchor),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            myImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
            myImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),

            myImageView.widthAnchor.constraint(equalToConstant: 42),
            myImageView.heightAnchor.constraint(equalToConstant: 42),
            ])
    }
}
