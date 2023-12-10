//
//  FavoriteItemTableCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 08.12.2023.
//

import UIKit
import Kingfisher

protocol FavoriteItemTableCellDelegate: AnyObject {
    func didClickedDeleteButton(indexPath: IndexPath)
}

class FavoriteItemTableCell: UITableViewCell {
    
    @IBOutlet private weak var favoriteImage: UIImageView!
    
    @IBOutlet private weak var favoriteTitle: UILabel!
    
    @IBOutlet private weak var favoriteDescription: UILabel!
    
    var indexPath: IndexPath?
    weak var delegate: FavoriteItemTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = 12
        
        self.favoriteImage.layer.cornerRadius = 12
        self.favoriteImage.layer.masksToBounds = true
        self.favoriteImage.layer.borderColor = UIColor(white: 0.95, alpha: 1).cgColor
        self.favoriteImage.layer.borderWidth = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func prepareForFavoriteItem(with model: FoodModel) {
        favoriteTitle.text = model.name ?? ""
        favoriteDescription.text = (model.price ?? "").appending(" ₺")
        
        let url = URL(string: model.imagePath ?? "")
        favoriteImage.kf.setImage(with: url)
    }
    
    @IBAction func buttonRemoveClicked(_ sender: Any) {
    self.delegate?.didClickedDeleteButton(indexPath: indexPath!)
    }
}
