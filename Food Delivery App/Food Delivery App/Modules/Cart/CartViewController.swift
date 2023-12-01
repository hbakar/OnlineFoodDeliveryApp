//
//  CartViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Alamofire

final class CartViewController: UIViewController {
  
    @IBOutlet weak var cartTableView: UITableView!
    
    var viewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        setNavigationBar()
        registerTableViewCell()
        registerTableView()
        viewModel?.delegate = self
        getData()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile-circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func tests(){
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getData()
    }
    
    private func getData() {
        let param : [String: Any] = ["kullanici_adi":"huseyinbakar"]
        viewModel?.getCartFoodList(with: Constants.allFoodsFromCartURL, params:param)
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
        
        cell.delegate = self
        cell.indexPath = indexPath
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
        case .removeFood:
            DispatchQueue.main.async {
                self.cartTableView.reloadData()
            }
        case .removeFailed(let error):
            print(error.localizedDescription)
        }
    }
  
}

extension CartViewController: CartItemTableCellDelegate {
    
    func didClickedDeleteButton(indexPath: IndexPath) {
        
        guard let liste = viewModel?.cartFoodList else { return }
        
        let model = liste [indexPath.row]
        
        let id = Int(model.sepet_yemek_id ?? "0")
        let params: [String: Any] = ["sepet_yemek_id": id, "kullanici_adi":"huseyinbakar"]
        viewModel?.removeFoodFromCart(with: Constants.removeFromCartURL, params: params)
      
        DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
            self.getData()
        }
    }
    
}
