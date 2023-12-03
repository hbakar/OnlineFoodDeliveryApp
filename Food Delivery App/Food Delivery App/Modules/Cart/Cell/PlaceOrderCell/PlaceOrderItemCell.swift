//
//  PlaceOrderItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 3.12.2023.
//

import UIKit

protocol PlaceOrderItemCellDelegate: AnyObject {
    func didClicked()
}

class PlaceOrderItemCell: UITableViewCell {

    weak var delegate: PlaceOrderItemCellDelegate?
    
    @IBAction func buttonPlaceOrderClicked(_ sender: Any) {
        self.delegate?.didClicked()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
