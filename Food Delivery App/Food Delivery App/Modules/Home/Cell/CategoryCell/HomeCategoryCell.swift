//
//  HomeCategoryCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 28.11.2023.
//

import UIKit

class HomeCategoryCell: UITableViewCell, HomeCategoryItemCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryList: [Category]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupCollectionViewCell()
       setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
    func didClicked(indexPath: IndexPath) {
        print(self.categoryList?[indexPath.row])
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupCollectionViewCell(){
        let nibName = String(describing: HomeCategoryItemCell.self)
        
        let nib = UINib(nibName: nibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
}

extension HomeCategoryCell: collectionV {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCategoryItemCell.self), for: indexPath) as? HomeCategoryItemCell {
            if let model = self.categoryList?[indexPath.row] {
                cell.prepareForCategoryItem(with: model)
                cell.delegate = self
                cell.indexPath = indexPath
            }
            cell.layer.cornerRadius = 12
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 44.0)
    }
    
}
