//
//  TimePickerViewCell.swift
//  CookingTimer
//
//  Created by Денис Павлов on 26.02.2023.
//

import UIKit

final class TimePickerViewCell: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        self.addSubview(numberLabel)
        self.addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        
        ])
    }
    
}

