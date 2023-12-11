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
    
    @IBOutlet private weak var cartQuantity: UILabel!
    
    var indexPath: IndexPath?
    weak var delegate: CartItemTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    fileprivate func configure() {
     
        self.cartImage.layer.cornerRadius = 12
        self.cartImage.layer.masksToBounds = true
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }
    
    func prepareForCartItem(with model: CartFoodResponseResult) {
        cartTitle.text = model.yemek_adi ?? ""
        cartDescription.text = (model.yemek_fiyat ?? "").appending(" ₺")
        
        if let quantity = model.yemek_siparis_adet {
            cartQuantity.text = "x \(Int(quantity) ?? 0)"
        }
        
        let url = URL(string: Constants.getFoodImage.appending(model.yemek_resim_adi ?? ""))
        cartImage.kf.setImage(with: url)
    }
    
    @IBAction func buttonRemoveClicked(_ sender: Any) {
       self.delegate?.didClickedDeleteButton(indexPath: indexPath!)
    }
}
