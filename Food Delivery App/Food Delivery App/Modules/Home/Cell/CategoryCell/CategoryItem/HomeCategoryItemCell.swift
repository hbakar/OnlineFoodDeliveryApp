//
//  HomeCategoryItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 28.11.2023.
//

import UIKit

protocol HomeCategoryItemCellDelegate: AnyObject {
    
    func didClicked(indexPath: IndexPath)
    
}

class HomeCategoryItemCell: UICollectionViewCell {

    @IBOutlet weak var buttonCategory: UIButton!
    
    weak var delegate: HomeCategoryItemCellDelegate?
    var indexPath: IndexPath?
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func prepareForCategoryItem(with model: Category) {
       
        DispatchQueue.main.async {
            self.buttonCategory.setTitle(model.name ?? "", for: .normal)
            self.buttonCategory.setTitleColor(.gray06, for: .highlighted)
            self.buttonCategory.layer.cornerRadius = 5
            self.buttonCategory.layer.borderWidth = 1
            self.buttonCategory.layer.borderColor = UIColor.gray07.cgColor
        }
      
    }
    
    @IBAction func buttonCategoryClicked(_ sender: Any) {
        
        self.delegate?.didClicked(indexPath: indexPath!)
        
        if buttonCategory.state == .selected {
            buttonCategory.backgroundColor = .secondary
        }
        else if buttonCategory.state == .normal {
            buttonCategory.backgroundColor = .primary
        }
    }
    
}
