//
//  FoodsViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit

final class FoodsViewController: UIViewController, FoodItemCellDelegate {
   
    
  
    
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var foodsCollectionView: UICollectionView!
    
    var viewModel: FoodsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
      
        setupCollectionViewCell()
        setupCollectionView()
      
        viewModel?.delegate = self
        viewModel?.getAllFoods(with: Constants.allFoodsURL)
        
        configure()
    }
    
    func didClicked(indexPath: IndexPath, with amount: Int) {
        if let model = viewModel?.foodList[indexPath.row] {
            
            if let name = model.name, let imageName = model.imagePath, let price = model.price {
               let params: [String: Any] = [
                    "yemek_adi": name,
                    "yemek_resim_adi": imageName,
                    "yemek_fiyat": price,
                    "yemek_siparis_adet":1,
                    "kullanici_adi": "huseyin_bakar"
                ]
                
                print("amount: \(amount)")
                
                self.viewModel?.addToCart(with: Constants.addToCartURL, params: params)
            }
        }
    }
    
    func addToFavorites(indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let selectedItem = viewModel?.foodList[indexPath.row] else { return }
        
        let detailViewController = DetailViewController(nibName: String(describing: DetailViewController.self), bundle: .main)
        
        detailViewController.chosenFood = selectedItem
        detailViewController.modalTransitionStyle = .coverVertical
        detailViewController.modalPresentationStyle = .fullScreen
        present(detailViewController,animated: true)
        
        return
    }
    
    private func setupCollectionView() {
        foodsCollectionView.delegate = self
        foodsCollectionView.dataSource = self
    }
    
    private func setupCollectionViewCell() {
        let nibName = String(describing: FoodItemCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        foodsCollectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    private func configure() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (width - 30) / 2, height: 235)
        foodsCollectionView.collectionViewLayout = layout
    }

}

extension FoodsViewController: collectionV {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel?.isSearch == true ? viewModel?.searchList.count : viewModel?.foodList.count
        return count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodItemCell.self), for: indexPath) as? FoodItemCell else { return UICollectionViewCell() }
              
        if viewModel?.isSearch == true {
           
            if let lst = viewModel?.searchList {
                cell.prepareForFood(with: lst[indexPath.row])
            }
        }
        else {
            if let lst = viewModel?.foodList {
                cell.prepareForFood(with: lst[indexPath.row])
            }
        }
        
        cell.indexPath = indexPath
        cell.foodDelegate = self
        return cell
    }
    
}

extension FoodsViewController: FoodViewModelDelegate {
    
    func notify(_ event: FoodsViewModelEvents) {
        switch event {
        case .didFetchFoodList:
            DispatchQueue.main.async {
                self.foodsCollectionView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription as! Error)
        case .didAddToCart:
            
            print(viewModel?.cardResponse)
            
        case .addToCartFailed(let error):
            print("\(error.localizedDescription)")
        }
    }
}


extension FoodsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            viewModel?.isSearch = false
            viewModel?.getAllFoods(with: Constants.allFoodsURL)
        }
        else {
            self.viewModel?.isSearch = true
            viewModel?.searchList = []
            guard let lst = viewModel?.foodList else { return }
            
            viewModel?.searchList = lst.filter{ $0.name?.lowercased().contains(searchText.lowercased()) == true}
            
            DispatchQueue.main.async {
                self.foodsCollectionView.reloadData()
            }
        }
    }
}
