//
//  MainViewProtocol.swift
//  CookingTimer
//
//  Created by Денис Павлов on 25.02.2023.
//

import Foundation

protocol MainViewProtocol: AnyObject {

    func refreshCollection()
    func updateTimeLabelInCells()
    var delegate: MainViewDelegate? { get set }
    
}


protocol MainViewDelegate: AnyObject {
    func getNumOfTimers() -> Int
    func getTimerWithIndex(_ index: Int) -> (String, Int, Int)
    func toggleWorkingTimerWithIndex(_ index: Int)
}
