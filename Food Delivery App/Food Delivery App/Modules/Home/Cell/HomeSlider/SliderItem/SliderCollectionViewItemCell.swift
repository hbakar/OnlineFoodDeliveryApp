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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareForSlideImage(with urlString: String) {
        
        let url = URL(string:urlString)
        slideImage.kf.setImage(with: url)
    }
    
}
