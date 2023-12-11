//
//  DetailTitleItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 9.12.2023.
//

import UIKit

protocol DetailTitleItemCellDelegate: AnyObject {
    func didClicked()
}

class DetailTitleItemCell: UITableViewCell {

    @IBOutlet private weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonAddFavorite: UIButton!
    
    weak var delegate: DetailTitleItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareForDetailTitle(with model: FoodsResponseResult) {
        self.labelTitle.text = model.name ?? ""
    }
    
    @IBAction func buttonAddFavoriteClicked(_ sender: Any) {
        delegate?.didClicked()
    }
    
}
