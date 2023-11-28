//
//  SliderCollectionViewItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Kingfisher

class SliderCollectionViewItemCell: UICollectionViewCell {
    
    @IBOutlet private weak var slideImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
     
    func prepareForSlideImage(with model: Slider) {
      //  let url = URL(string: urlString)
        
       // self.slideImage.kf.setImage(with: url)
    
        self.titleLabel.text = model.title
        self.locationLabel.text = model.address
        
        let url = URL(string: model.imageURL)!
        self.slideImage.kf.setImage(with: url)
    }
    
}
