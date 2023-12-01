//
//  OnboardingCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 24.11.2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    
    @IBOutlet weak var gradientView: Gradient!
    
    @IBOutlet private weak var onboardImage: UIImageView!
    
    @IBOutlet weak var onboardTitle: UILabel!
  
    @IBOutlet weak var onboardDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // setGradientBackground()
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = 24
    }
    
    func prepareforOnboardItem(with model: OnboardingSlide) {
        
        DispatchQueue.main.async {
            self.onboardTitle.text = model.title
            self.onboardDescription.text = model.description
            self.onboardImage.image = model.image
        }
    }
    
}
