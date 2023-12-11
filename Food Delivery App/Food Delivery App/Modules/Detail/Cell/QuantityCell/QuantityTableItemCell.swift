//
//  QuantityTableItemCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 9.12.2023.
//

import UIKit

protocol QuantityTableItemCellDelegate: AnyObject {
    func didAddToCart(with q: Int)
}

class QuantityTableItemCell: UITableViewCell {
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    weak var delegate: QuantityTableItemCellDelegate?
    private var quantity: Int = 0
    
    @IBOutlet weak var quantityTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonAdd.layer.borderColor = UIColor.primaryColor.cgColor
        buttonAdd.layer.borderWidth = 1
        buttonAdd.layer.cornerRadius = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        
        DispatchQueue.main.async {
            self.quantity = Int((sender as? UIStepper)?.value ?? 0)
            self.quantityTextField.text =  "\(String(describing: self.quantity))"
        }
    }
    
    @IBAction func buttonAddClicked(_ sender: Any) {
        guard let qStr = quantityTextField.text else { return }
        self.quantity = Int(qStr) ?? 1
        self.delegate?.didAddToCart(with: quantity)
    }
}
