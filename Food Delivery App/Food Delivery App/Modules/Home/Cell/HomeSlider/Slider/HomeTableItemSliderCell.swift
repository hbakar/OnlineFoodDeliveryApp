//
//  HomeTableItemSliderCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit

class HomeTableItemSliderCell: UITableViewCell, collectionV {
    
    var items: [String] = ["1","2","3"]
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        setupCollectionViewLayout()
        setupCollectionViewItemCell()
        
    }
    
    private func setupCollectionView(){
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
    }
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = sliderCollectionView.frame.size.height
        layout.itemSize = CGSizeMake(screenWidth, screenHeight);
        sliderCollectionView.collectionViewLayout = layout
    }
    
    private func setupCollectionViewItemCell() {
        let nibName = String(describing: SliderCollectionViewItemCell.self)
        let nib: UINib = UINib(nibName: nibName, bundle: .main)
        sliderCollectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
        return cell
    }
    
}
