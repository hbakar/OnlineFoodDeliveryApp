//
//  SettingsViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    var viewModel: SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCell()
        registerTableView()
        viewModel?.delegate = self
        viewModel?.getSettingsData()
    }
    
    private func registerTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        let nibName = String(describing: SettingsDarkModeItemCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        settingsTableView.register(nib, forCellReuseIdentifier: nibName)
    }
}


extension SettingsViewController: tableV {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = self.viewModel?.settingsTableItems.count else { return 0}
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableItems = viewModel?.settingsTableItems[section] else { return 0}
        switch tableItems {
        case .darkMode:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableItems = viewModel?.settingsTableItems[indexPath.section],let settingsList = viewModel?.settingsList else {return UITableViewCell() }
        
        switch tableItems {
        case .darkMode:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsDarkModeItemCell.self), for: indexPath) as? SettingsDarkModeItemCell {
                cell.delegate = self
                cell.indexPath = indexPath
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension SettingsViewController: SettingsViewModelDelegate {
    func notify(_ event: SettingsViewModelEvent) {
        switch event {
        case .didFetchSettingsList:
            DispatchQueue.main.async {
                self.settingsTableView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        }
    }
}

extension SettingsViewController: SettingsDarkModeItemCellDelegate {
    func didClicked(indexPath: IndexPath) {
        print(indexPath)
        
        print("Dark mode included")
    }
}
