//
//  DetailViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 24.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
  
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupTableViewCell()
        setupTableView()
        setNavigationBar()
        viewModel?.delegate = self
        viewModel?.getData()
    }
    
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    private func setupTableViewCell() {
        let nibName = String(describing: DetailItemImageViewCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        detailTableView.register(nib, forCellReuseIdentifier: nibName)
        
        let nibNameTitle = String(describing: DetailTitleItemCell.self)
        let nibTitle = UINib(nibName: nibNameTitle, bundle: .main)
        detailTableView.register(nibTitle, forCellReuseIdentifier: nibNameTitle)
        
        let nibNamePrice = String(describing: PriceTableItemCell.self)
        let nibPrice = UINib(nibName: nibNamePrice, bundle: .main)
        detailTableView.register(nibPrice, forCellReuseIdentifier: nibNamePrice)
        
        let nibNameQuantity = String(describing: QuantityTableItemCell.self)
        let nibQuantity = UINib(nibName: nibNameQuantity, bundle: .main)
        detailTableView.register(nibQuantity, forCellReuseIdentifier: nibNameQuantity) 
        
        let nibNameAddToCart = String(describing: AddtoCartTableItemCell.self)
        let nibAddtoCart = UINib(nibName: nibNameAddToCart, bundle: .main)
        detailTableView.register(nibAddtoCart, forCellReuseIdentifier: nibNameAddToCart)
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "favorite")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(goToFavorite)),UIBarButtonItem(image: UIImage(named: "profile-circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))]
    }
    
    @objc func goToFavorite() {
        let favoriteViewController = MyFavoritesViewController(nibName: String(describing: MyFavoritesViewController.self), bundle: .main)
        favoriteViewController.modalPresentationStyle = .formSheet
        favoriteViewController.viewModel = MyFavoritesViewModel()
        self.present(favoriteViewController,animated: true)
    }
    
    @objc func tests() {
        print("test")
    }
    
}

extension DetailViewController: tableV {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = viewModel?.detailTableItems.count else {
            return 0
        }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableItems = viewModel?.detailTableItems[section] else { return 0}
        switch tableItems {
        case .detailImageItem:
            return 1
        case .detailTitleItem:
            return 1
        case .detailPriceItem:
            return 1
        case .detailQuantity:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailTableItems = viewModel?.detailTableItems[indexPath.section] else {
            return UITableViewCell()
        }
        
        switch detailTableItems {
        case .detailImageItem:
            guard let detailImageCell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailItemImageViewCell.self), for: indexPath) as? DetailItemImageViewCell else { return UITableViewCell()}
          
            if let model = viewModel?.detail {
                detailImageCell.prepareForDetailImage(with: model)
            }
         
            return detailImageCell
        case .detailTitleItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailTitleItemCell.self), for: indexPath) as? DetailTitleItemCell else { return UITableViewCell()}
          
            if let model = viewModel?.detail {
                cell.delegate = self
                cell.prepareForDetailTitle(with: model)
            }
         
            return cell
        case .detailPriceItem:
            guard let detailPriceCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PriceTableItemCell.self), for: indexPath) as? PriceTableItemCell else { return UITableViewCell()}
          
            if let model = viewModel?.detail {
                detailPriceCell.prepareForFoodPrice(with: model)
            }
         
            return detailPriceCell
        case .detailQuantity:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QuantityTableItemCell.self), for: indexPath) as? QuantityTableItemCell else { return UITableViewCell()}
            cell.delegate = self
            return cell
        }
    }
}


extension DetailViewController: QuantityTableItemCellDelegate {
   
    func didAddToCart(with q: Int) {
        if let model = viewModel?.detail {
            let params: [String: Any] = ["yemek_adi":model.name ?? "","yemek_resim_adi":model.imagePath ?? "","yemek_fiyat":model.price ?? "","yemek_siparis_adet":q,"kullanici_adi":"huseyinbakar"]
            viewModel?.addToCart(with: Constants.addToCartURL, params: params)
            
            showAlert(title: "Added to Cart", message: "Successfully added to cart")
        }
    }
   
}

extension DetailViewController: DetailViewModelDelegate {
    func notify(_ event: DetailViewModelEvents) {
        switch event {
        case .didFetchDetail:
            DispatchQueue.main.async {
                self.detailTableView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        case .didAddtoCart:
            print("sepete ekle çalıştı")
        case .failedToAddtoCart(let error):
            print(error.localizedDescription)
        case .didAddtoFavorites:
            showAlert(title: "Added To Favorites", message: "Succesfully Added To Favorites")
        case .failedAddtoFavorites(let error):
            print(error.localizedDescription)
        }
    }
}

extension DetailViewController: DetailTitleItemCellDelegate {
    func didClicked() {
        guard let model = self.viewModel?.detail else {
            return
        }
        viewModel?.addToFavorites(with: model)
        
    }
}
