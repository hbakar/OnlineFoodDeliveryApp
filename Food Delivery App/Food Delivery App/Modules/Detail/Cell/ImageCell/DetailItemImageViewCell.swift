//
//  DetailItemImageViewCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 1.12.2023.
//

import UIKit
import Kingfisher

class DetailItemImageViewCell: UITableViewCell {

    @IBOutlet private weak var detailImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailImage.layer.masksToBounds = true
        detailImage.layer.cornerRadius = 12
        detailImage.layer.borderWidth = 1
        detailImage.layer.borderColor = UIColor.gray10.cgColor
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
   
    }
    
    func prepareForDetailImage(with model: FoodsResponseResult) {
        let path = Constants.getFoodImage.appending(model.imagePath ?? "")
        let url = URL(string: path)!
        self.detailImage.kf.setImage(with: url)
    }
    
}
