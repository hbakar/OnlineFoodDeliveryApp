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
        setupLayout()
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       // layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let width = (collectionView.frame.width - 30) / 2.2
        let height = 44.0
        layout.itemSize = CGSize(width: width, height: height)
        collectionView.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func didClicked(indexPath: IndexPath) {
        
        print(self.categoryList?[indexPath.row])
    
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupCollectionViewCell() {
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
        return CGSize(width: 180.0, height: 44.0)
    }
    
}
