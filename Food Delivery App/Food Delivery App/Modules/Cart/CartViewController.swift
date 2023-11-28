//
//  CartViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit

final class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    
    var viewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCell()
        registerTableView()
        
        viewModel?.delegate = self
        
        let params: [String: Any] = ["kullanici_adi":""] // kendi kullanıcı adım gelecek
        viewModel?.getCartFoodList(with: Constants.allFoodsFromCartURL, params:params)
    }
    
    private func registerTableView() {
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        let nibName = String(describing: CartItemTableCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        cartTableView.register(nib, forCellReuseIdentifier: nibName)
    }

}

extension CartViewController: tableV {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.cartFoodList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartItemTableCell.self), for: indexPath) as? CartItemTableCell else { return UITableViewCell() }
        
        guard let model = self.viewModel?.cartFoodList[indexPath.row] else { return UITableViewCell() }
        
        cell.prepareForCartItem(with: model)
        return cell
    }
}

extension CartViewController: CartViewModelDelegate {
    func notify(_ events: CartViewModelEvents) {
        switch events {
        case .didFetchCartList:
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        }
    }
}
