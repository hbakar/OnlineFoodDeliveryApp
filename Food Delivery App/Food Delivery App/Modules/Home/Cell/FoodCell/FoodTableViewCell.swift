//
//  FoodTableViewCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 28.11.2023.
//

import UIKit

protocol FoodTableViewCellDelegate: AnyObject {
    func didClickedCollectionItem(with indexPath: IndexPath)
}

class FoodTableViewCell: UITableViewCell, FoodItemCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: HomeViewModelProtocol?
    
    var indexPath: IndexPath?
    weak var delegate: FoodTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupFoodCollectionItemCell()
        setupFoodCollectionCell()
        setupLayout()
    }
    
    private func setupFoodCollectionCell() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func setupFoodCollectionItemCell() {
        let nibName = String(describing: FoodItemCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: (width - 30) / 2, height: 235)
        collectionView.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func didClicked(indexPath: IndexPath,with amount: Int) {
        
        if let list = viewModel?.isSearch == true ? self.viewModel?.searchList : self.viewModel?.foodList
        {
            let model = list[indexPath.row]
            let name = model.name ?? ""
            let img = model.imagePath ?? ""
            let price = Int(model.price ?? "0") ?? 0
            
            let params: [String: Any] = ["yemek_adi":name,"yemek_resim_adi":img,"yemek_fiyat":price,"yemek_siparis_adet":amount,"kullanici_adi":"huseyinbakar"]
            viewModel?.addToCart(with: Constants.addToCartURL, params: params)
        }
        
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    func addToFavorites(with indexPath: IndexPath) {
        
        if let item = viewModel?.isSearch == true ? viewModel?.searchList[indexPath.row] : viewModel?.foodList[indexPath.row] {
            viewModel?.addToFavorites(with: item)
        }
    }
    
    func addToCart(with indexPath: IndexPath) {
        
    }
}

extension FoodTableViewCell: collectionV {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = viewModel?.isSearch == true ? (self.viewModel?.searchList.count ?? 0) : (self.viewModel?.foodList.count ?? 0)
        //   print("\(number) number")
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodItemCell.self), for: indexPath) as? FoodItemCell else { return UICollectionViewCell()}
        
        if viewModel?.isSearch == true {
            if let list = self.viewModel?.searchList {
                cell.prepareForFood(with: list[indexPath.row])
                cell.indexPath = indexPath
            }
        }
        else {
            if let list = self.viewModel?.foodList {
                cell.prepareForFood(with: list[indexPath.row])
            }
            cell.foodDelegate = self
            cell.indexPath = indexPath
            viewModel?.isSearch = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.indexPath = indexPath
        self.delegate?.didClickedCollectionItem(with: indexPath)
    }
}
