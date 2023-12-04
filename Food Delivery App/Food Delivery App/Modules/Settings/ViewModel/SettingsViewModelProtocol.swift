//
//  SettingsViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import Foundation

protocol SettingsViewModelProtocol {
    var delegate: SettingsViewModelDelegate? {get set}
    var settingsList: [SettingsModel] { get set }
    var settingsTableItems: [SettingsTableItems] {get set}
    
    func getSettingsData()
}
