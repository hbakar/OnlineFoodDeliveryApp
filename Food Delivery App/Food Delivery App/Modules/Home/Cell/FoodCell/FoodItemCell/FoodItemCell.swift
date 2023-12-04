//
//  FoodItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Kingfisher

protocol FoodItemCellDelegate: AnyObject {
    func didClicked(indexPath: IndexPath,with amount: Int)
    
    func addToCart(with indexPath: IndexPath)
    
    func addToFavorites(with indexPath: IndexPath)
}

class FoodItemCell: UICollectionViewCell {
    
    @IBOutlet weak var buttonFavorites: UIButton!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var amountStepper: UIStepper!
    
    @IBOutlet private weak var priceLabel: UILabel!
    
    @IBOutlet private weak var foodImage: UIImageView!
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    weak var foodDelegate: FoodItemCellDelegate?
    
    var amount: Int = 0
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    @IBAction func buttonFavoritesClicked(_ sender: Any) {
        self.foodDelegate?.addToFavorites(with: indexPath!)
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
        priceLabel.text = (model.price ?? "").appending(" ₺")
    }
    
    @IBAction func amountStepperChanged(_ sender: Any) {
        amount = Int((sender as? UIStepper)?.value ?? 0)
        self.amountTextField.text = String(amount)
    }
    
    @IBAction func buttonAddClicked(_ sender: Any) {
        
        self.foodDelegate?.didClicked(indexPath: indexPath!,with: amount)
        
    }
    
}
