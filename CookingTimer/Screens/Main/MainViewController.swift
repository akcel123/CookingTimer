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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        view.backgroundColor = .systemCyan

        //load models and startTimers
        loadModelFromUserDefaults()
        
        
        mainView = MainView(frame: view.bounds)
        mainView.delegate = self
        view.addSubview(mainView as! UIView)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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

//MARK: -  MainViewDelegate
extension MainViewController: MainViewDelegate {
    func toggleWorkingTimerWithIndex(_ index: Int) {
        timerModels[index].pauseTimer()
        
    }
    

    func getTimerWithIndex(_ index: Int) -> (String, Int, Int) {
        return (timerModels[index].name ?? "", timerModels[index].currentTime, timerModels[index].endTimeInSeconds)
    }
    
    func getNumOfTimers() -> Int {
        return timerModels.count
    }
    
    
}


// MARK: - Timer
private extension MainViewController {
    func createTimer() {
        TimerManager.shared.startTimer()
        TimerManager.shared.tick = updateTimer
        for timer in timerModels {
            timer.startTimer()
        }
  }
  
  func cancelTimer() {
      TimerManager.shared.stopTimer()
  }
  
  func updateTimer() {
      for timer in timerModels {
          timer.tick()
      }
      mainView.updateTimeLabelInCells()
  }
}


// MARK: - User Defaults
extension MainViewController {
    public func saveModelToUserDefaults() {
        var names: [String] = []
        var msTimes: [Double] = []
        var endTimes: [Int] = []
        for timers in timerModels {
            let (name, msTime, endTime) = timers.getPropForUserDefaults()
            names.append(name)
            msTimes.append(msTime)
            endTimes.append(endTime)
        }
        UserDefaults.standard.set(names, forKey: UserDefaultsKeys.nameString)
        UserDefaults.standard.set(msTimes, forKey: UserDefaultsKeys.msTime)
        UserDefaults.standard.set(endTimes, forKey: UserDefaultsKeys.endTime)
    }
    
    private func loadModelFromUserDefaults() {
        guard let names = UserDefaults.standard.array(forKey: UserDefaultsKeys.nameString) as? [String],
                let msTimes = UserDefaults.standard.array(forKey: UserDefaultsKeys.msTime) as? [Double],
                let endTimes = UserDefaults.standard.array(forKey: UserDefaultsKeys.endTime) as? [Int] else { return }
        for i in 0..<names.count {
            let timerModel = TimerModel(timeIncSeconds: endTimes[i])
            timerModel.setPropForUserDefaults(name: names[i], msTime: msTimes[i], endTime: endTimes[i])
            self.timerModels.append(timerModel)
        }
        createTimer()
    }
}
