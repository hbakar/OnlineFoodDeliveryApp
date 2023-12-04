//
//  SettingsViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import Foundation

final class SettingsViewModel: SettingsViewModelProtocol {
    
    var settingsTableItems: [SettingsTableItems] = []
    weak var delegate: SettingsViewModelDelegate?
    var settingsList: [SettingsModel] = []
    
    func getSettingsData() {
        settingsList = [SettingsModel(id: 1, name: "Dark Mode"),SettingsModel(id: 2, name: "Select Language")]
        settingsTableItems.append(.darkMode)
        self.delegate?.notify(.didFetchSettingsList)
    }
}


protocol SettingsViewModelDelegate: AnyObject {
    func notify(_ event: SettingsViewModelEvent)
}

enum SettingsViewModelEvent {
    case didFetchSettingsList
    case fetchFailed(Error)
}

enum SettingsTableItems {
    case darkMode
}
