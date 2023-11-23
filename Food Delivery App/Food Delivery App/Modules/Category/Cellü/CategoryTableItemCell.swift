//
//  CategoryTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit
import Kingfisher

protocol CategoryTableItemCellDelegate {
    func didClicked()
}

class CategoryTableItemCell: UITableViewCell {

    @IBOutlet private weak var categoryImage: UIImageView!
     
    @IBOutlet private weak var categoryTitle: UILabel!
    
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func prepareForCategoryItem(with model: FoodsResponseResult) {
        
    }
    
}
