//
//  AddtoCartTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 10.12.2023.
//

import UIKit

protocol AddtoCartTableItemCellDelegate: AnyObject {
    func didAddToCartClicked()
}

class AddtoCartTableItemCell: UITableViewCell {

    var delegate: AddtoCartTableItemCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAddToCartClicked(_ sender: Any) {
        self.delegate?.didAddToCartClicked()
    }
    
}
