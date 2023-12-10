//
//  SettingsDarkModeItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import UIKit

protocol SettingsDarkModeItemCellDelegate: AnyObject {
    func didClicked(indexPath: IndexPath)
}

class SettingsDarkModeItemCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    weak var delegate: SettingsDarkModeItemCellDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
        let appDelegate = UIApplication.shared.windows.first
        if sender.isOn {
            if #available(iOS 13.0, *) {
                appDelegate?.overrideUserInterfaceStyle = .dark
                UserDefaults.standard.setValue(true, forKey: "isDark")
            }
        }
        else {
            if #available(iOS 13.0, *) {
                appDelegate?.overrideUserInterfaceStyle = .light
                UserDefaults.standard.setValue(false, forKey: "isDark")
            }
        }
        
        
        overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        UserDefaults.standard.setValue(sender.isOn, forKey: "isDark")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepareForSettingsItem(with model: SettingsModel) {
        self.titleLabel.text = model.name
    }
    
    
}
