//
//  TimerCell.swift
//  SFERATestApp
//
//  Created by Anton Yaroshchuk on 15.07.2021.
//

import UIKit

class TimerCell: UITableViewCell {
    static let identifier = "TimerCellIdentifier"
    var nameLabel = UILabel()
    var counterLabel = UILabel()
    var pauseButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(counterLabel)
        cofigureButton()
        configureNameLabel()
        configureCounterLabel()
        setNameLabelConstraints()
        setCounterConstraints()
        setButtonConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureNameLabel(){
        nameLabel.numberOfLines = 0
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func configureCounterLabel(){
        counterLabel.numberOfLines = 0
        counterLabel.adjustsFontSizeToFitWidth = true
    }
    
    func cofigureButton(){
        pauseButton = UIButton(type: .system)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        pauseButton.layer.cornerRadius = 10
        pauseButton.layer.backgroundColor = .init(srgbRed: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        pauseButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        pauseButton.setTitle("Пауза", for: .normal)
        contentView.addSubview(pauseButton)
        
    }
    
    func setNameLabelConstraints(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        ])
    }
    
    func setCounterConstraints(){
        counterLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            counterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            counterLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            counterLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9)
        ])
    }
    
    func setButtonConstraints(){
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pauseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pauseButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            pauseButton.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8)
        ])
    }
}
