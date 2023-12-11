//
//  CartViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Alamofire
import Lottie

final class CartViewController: UIViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    
    var viewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        registerTableViewCell()
        registerTableView()
        viewModel?.delegate = self
        getData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
      // control()
    }
    
    private func showAnimation() {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("notFound")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        animationView.center = cartTableView.center
        
        animationView.animationSpeed = 1.5
        animationView.loopMode = .loop
        cartTableView.backgroundView = animationView
        cartTableView.separatorStyle = .none
        animationView.play()
    }
    
    private func control() {
        if let liste = viewModel?.cartFoodList {
            if liste.count == 0 {
                showAnimation()
            }
        }
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
        
      //  control()
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
    
    private func setCookie() {
        if UserDefaults.standard.integer(forKey: "cookieFoodCount") > 0 {
            Singleton.shared.cartItemCount = UserDefaults.standard.integer(forKey: "cookieFoodCount")
        }
        else {
            let count = (self.viewModel?.cartFoodList.count ?? 0) + 1
            UserDefaults.standard.set(count, forKey: "cookieFoodCount")
            Singleton.shared.cartItemCount = count
        }
    }
    
    func notify(_ events: CartViewModelEvents) {
        switch events {
        case .didFetchCartList:
            setCookie()
            DispatchQueue.main.async {
                self.cartTableView.dataSource = self
                self.cartTableView.reloadData()
                
              //  self.control()
            }
        case .fetchFailed(let error):
            self.cartTableView.dataSource = nil
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
        
        showConfirmationAlert(title: "Warning", message: "Are you sure you want to delete?") { b in
            if b == true
            {
                guard let liste = self.viewModel?.cartFoodList else { return }
                let model = liste[indexPath.row]
                
                let id = Int(model.sepet_yemek_id ?? "0")
                let params: [String: Any] = ["sepet_yemek_id": id!, "kullanici_adi":"huseyinbakar"]
                self.viewModel?.removeFoodFromCart(with: Constants.removeFromCartURL, params: params)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                    self.getData()
                }
                
                self.control()
            }
        }
    }
    
}
