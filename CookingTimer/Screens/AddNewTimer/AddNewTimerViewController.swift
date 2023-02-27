//
//  AddNewTimerViewController.swift
//  CookingTimer
//
//  Created by Денис Павлов on 26.02.2023.
//

import UIKit

class AddNewTimerViewController: UIViewController {

    private var addNewTimerView = AddNewTimerView()
    private var configCallback: ((String, Int) -> Void)!
        
    init(callback: @escaping (String, Int) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.configCallback = callback
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray
        
        addNewTimerView = AddNewTimerView(frame: view.bounds)
        addNewTimerView.delegate = self
        view.addSubview(addNewTimerView)

    }
    
}

//MARK: - AddNewTimerViewDelegate
extension AddNewTimerViewController: AddNewTimerViewDelegate {
    func startButtonTapped(timeInSeconds: Int, name: String) {
        configCallback(name, timeInSeconds)
        navigationController?.popViewController(animated: true)
    }
    
    
}
