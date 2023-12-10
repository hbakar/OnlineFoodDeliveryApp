//
//  DetailTitleItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 9.12.2023.
//

import UIKit

class DetailTitleItemCell: UITableViewCell {

    @IBOutlet private weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareForDetailTitle(with model: FoodsResponseResult) {
        self.labelTitle.text = model.name ?? ""
    }
    
}
