//
//  PriceTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 9.12.2023.
//

import UIKit

class PriceTableItemCell: UITableViewCell {
    
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func prepareForFoodPrice(with model: FoodsResponseResult) {
        self.priceLabel.text = (model.price ?? "0").appending(" ₺")
    }
    
}
