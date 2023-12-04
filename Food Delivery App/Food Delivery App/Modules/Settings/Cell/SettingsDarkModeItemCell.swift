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
        
        overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        UserDefaults.standard.setValue(sender.isOn, forKey: "isDarkMode")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func prepareForSettingsItem(with model: SettingsModel) {
        self.titleLabel.text = model.name
    }
    
    
}
