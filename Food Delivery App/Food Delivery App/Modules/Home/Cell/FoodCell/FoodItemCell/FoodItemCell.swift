//
//  FoodItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Kingfisher

protocol FoodItemCellDelegate: AnyObject {
    func didClicked(indexPath: IndexPath)
}

class FoodItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var priceLabel: UILabel!
    
    @IBOutlet private weak var foodImage: UIImageView!
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    weak var foodDelegate: FoodItemCellDelegate?
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    func configure() {
        foodImage.clipsToBounds = true
        foodImage.layer.cornerRadius = 12
        
        buttonAdd.layer.borderColor = UIColor.primary.cgColor
        buttonAdd.layer.borderWidth = 1
        
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderColor = UIColor(white: 0.95, alpha: 1).cgColor
        self.contentView.layer.borderWidth = 1
        
        /*
         self.contentView.layer.shadowColor = UIColor.black.cgColor
         self.contentView.layer.shadowOpacity = 0.5
         self.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
         self.contentView.layer.shadowRadius = 4
         */
    }
    
    func prepareForFood(with model: FoodsResponseResult) {
        
        if var imgPath = model.imagePath {
            imgPath = Constants.getFoodImage.appending(imgPath)
            let url = URL(string: imgPath)
            foodImage.kf.setImage(with: url)
        }
        
        titleLabel.text = model.name ?? ""
        priceLabel.text = model.price?.appending(" ₺") ?? ""
    }
    
    @IBAction func buttonAddClicked(_ sender: Any) {
        self.foodDelegate?.didClicked(indexPath: indexPath!)
    }
    
}
