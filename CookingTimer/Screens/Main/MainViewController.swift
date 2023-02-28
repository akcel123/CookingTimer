//
//  MainViewController.swift
//  Multitimer
//
//  Created by Денис Павлов on 20.02.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var rightBarButtonItem = UIBarButtonItem()
    private var mainView: MainViewProtocol = MainView()
    private var timerModels: [TimerModel] = [] {
        didSet {
            for timer in timerModels {
                timer.startTimer()
            }
            if timerModels.count == 0 {
                cancelTimer()
            }
           
            mainView.refreshCollection()
            mainView.updateTimeLabelInCells()
        }
    }
    private var clockTimer: Timer?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        view.backgroundColor = .systemCyan

        mainView = MainView(frame: view.bounds)
        mainView.delegate = self
        view.addSubview(mainView as! UIView)
    }
 
}


// MARK: - settings
private extension MainViewController {
    
    func setupNavigationBar() {
        rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTimer))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        self.title = "Мультитаймер"
    }
}


// MARK: - creating New Timer
private extension MainViewController {
    @objc func addNewTimer() {
        createTimer()
        let addNewTimerViewController = AddNewTimerViewController { [weak self] name, timeInSeconds in
            self?.createTimer()
            let timerModel = TimerModel(name: name, timeIncSeconds: timeInSeconds)
            self?.timerModels.append(timerModel)
   
        }
        navigationController?.pushViewController(addNewTimerViewController, animated: true)
    }


    
}

//MARK: MainViewDelegate
extension MainViewController: MainViewDelegate {
    func toggleWorkingTimerWithIndex(_ index: Int) {
        timerModels[index].stopTimer()
        
    }
    

    func getTimerWithIndex(_ index: Int) -> (String, Int, Int) {
        return (timerModels[index].name ?? "", timerModels[index].currentTime, timerModels[index].timeIncSeconds)
    }
    
    func getNumOfTimers() -> Int {
        return timerModels.count
    }
    
    
}


// MARK: - Timer
extension MainViewController {
    func createTimer() {
        if clockTimer == nil {
            let timer = Timer(timeInterval: 1.0,
                            target: self,
                            selector: #selector(updateTimer),
                            userInfo: nil,
                            repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            timer.tolerance = 0.1
          
            clockTimer = timer
        }
    
        for timer in timerModels {
            timer.startTimer()
        }
      
  }
  
  func cancelTimer() {
    clockTimer?.invalidate()
    clockTimer = nil
  }
  
  @objc func updateTimer() {
      for timer in timerModels {
          timer.tick()
      }
      mainView.updateTimeLabelInCells()
  }
}

