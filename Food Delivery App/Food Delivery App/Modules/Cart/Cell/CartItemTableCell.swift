//
//  CartItemTableCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 25.11.2023.
//

import UIKit
import Kingfisher

protocol CartItemTableCellDelegate: AnyObject {
    func didClickedDeleteButton(indexPath: IndexPath)
}

class CartItemTableCell: UITableViewCell {

    @IBOutlet private weak var cartImage: UIImageView!
    
    @IBOutlet private weak var cartTitle: UILabel!
    
    @IBOutlet private weak var cartDescription: UILabel!
    
    var indexPath: IndexPath?
    weak var delegate: CartItemTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
    func prepareForCartItem(with model: CartFoodResponseResult) {
        cartTitle.text = model.yemek_adi ?? ""
        cartDescription.text = (model.yemek_fiyat ?? "").appending(" ₺")
        
        let url = URL(string: Constants.getFoodImage.appending(model.yemek_resim_adi ?? ""))
        cartImage.kf.setImage(with: url)
    }
    
}
