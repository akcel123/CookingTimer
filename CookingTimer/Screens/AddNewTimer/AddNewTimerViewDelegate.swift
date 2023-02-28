//
//  AddNewTimerViewDelegate.swift
//  CookingTimer
//
//  Created by Денис Павлов on 28.02.2023.
//

import Foundation

protocol AddNewTimerViewDelegate: AnyObject {
    func startButtonTapped(timeInSeconds: Int, name: String)
}
