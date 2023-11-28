//
//  FoodTableViewCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 28.11.2023.
//

import UIKit



class FoodTableViewCell: UITableViewCell, FoodItemCellDelegate {
   
    func didClicked(indexPath: IndexPath) {
        print("ürün \(indexPath)")
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foodList: [FoodsResponseResult]?
    
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
    
}

extension FoodTableViewCell: collectionV {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.foodList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodItemCell.self), for: indexPath) as? FoodItemCell else { return UICollectionViewCell()}
        
        if let model = self.foodList?[indexPath.row] {
            cell.prepareForFood(with: model)
            cell.foodDelegate = self
            cell.indexPath = indexPath
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
