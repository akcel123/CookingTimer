//
//  AddNewTimerView.swift
//  CookingTimer
//
//  Created by Денис Павлов on 26.02.2023.
//

import UIKit

final class AddNewTimerView: UIView {

    //MARK: - UI private properties
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Название таймера"
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 4
        return textField
    }()
    
    
    private let timePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()

    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Старт", for: .normal)
        button.backgroundColor = .systemGreen
        button.isEnabled = false
        button.alpha = 0.5
        button.layer.cornerRadius = 8
        return button
    }()
    
    weak var delegate: (AddNewTimerViewDelegate)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(timePickerView)
        addSubview(startButton)
        addSubview(nameTextField)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

        setupConstraints()
        timePickerView.dataSource = self
        timePickerView.delegate = self
        nameTextField.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped(timeInSeconds: timePickerView.selectedRow(inComponent: 0) * 60 * 60 + timePickerView.selectedRow(inComponent: 1) * 60 + timePickerView.selectedRow(inComponent: 2), name: nameTextField.text ?? "")
    }
    
    
    
    
}


// MARK: - contraints
private extension AddNewTimerView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timePickerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            timePickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            timePickerView.heightAnchor.constraint(equalToConstant: 256),
            
            nameTextField.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 32),
            nameTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            nameTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            nameTextField.heightAnchor.constraint(equalToConstant: 32),
            
            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32),
            startButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            startButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 32),
            startButton.heightAnchor.constraint(equalToConstant: 64)
            
        
        
        ])
    }
}


// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddNewTimerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 24
        case 1: return 60
        case 2: return 60
        default: return 0
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var customView: TimePickerViewCell
            
        if let view = view as? TimePickerViewCell {
            customView = view
        } else {
            customView = TimePickerViewCell()
        }
        
        if component == 0 {
            customView.numberLabel.text = String(format: "%02d", row)
            customView.titleLabel.text = "hour"
        } else if component == 1 {
            customView.numberLabel.text = String(format: "%02d", row)
            customView.titleLabel.text = "minute"
        } else {
            customView.numberLabel.text = String(format: "%02d", row)
            customView.titleLabel.text = "second"
        }
        return customView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.selectedRow(inComponent: 0) == 0 && pickerView.selectedRow(inComponent: 1) == 0 && pickerView.selectedRow(inComponent: 2) == 0 {
            startButton.isEnabled = false
            startButton.alpha = 0.5
        } else {
            startButton.isEnabled = true
            startButton.alpha = 1
        }
    }

}

//MARK: - UITextFieldDelegate
extension AddNewTimerView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
