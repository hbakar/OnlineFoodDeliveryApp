//
//  ProfileTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//



import UIKit

class ProfileTableItemCell: UITableViewCell {

    @IBOutlet private weak var profileItemImage: UIImageView!
    
    @IBOutlet private weak var profileItemTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareForProfileItem(with model: Profile) {
        profileItemTitle.text = model.title
        profileItemImage.image = UIImage(named: model.image)
    }
}
