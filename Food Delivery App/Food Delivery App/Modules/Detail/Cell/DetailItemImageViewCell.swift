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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareForDetailImage(with model: FoodsResponseResult)
    {
        let path = Constants.getFoodImage.appending(model.imagePath ?? "")
        let url = URL(string: path)!
        
        self.detailImage.kf.setImage(with: url)
    }
    
}
