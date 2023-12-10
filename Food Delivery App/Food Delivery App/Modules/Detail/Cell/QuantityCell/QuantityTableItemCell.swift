//
//  QuantityTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 9.12.2023.
//

import UIKit

class QuantityTableItemCell: UITableViewCell {

    @IBOutlet weak var quantityTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        
        quantityTextField.text = "\(String(describing: Int((sender as? UIStepper)?.value ?? 0)))"
    }
    
}
