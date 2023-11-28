//
//  HomeTableItemSliderCell.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit

class HomeTableItemSliderCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var pageControl: UIPageControl!
    var index = 0
    
    var sliderDataList = [Slider]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        setupCollectionViewLayout()
        setupCollectionViewItemCell()
 
        addData()
        startAutoScrolling()
  
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        let screenWidth = UIScreen.main.bounds.width - 32
        let screenHeight = collectionView.frame.size.height
        layout.itemSize = CGSizeMake(screenWidth, screenHeight);
       
        collectionView.collectionViewLayout = layout
        
    }
    
    private func setupCollectionViewItemCell() {
        
        let nibName = String(describing: SliderCollectionViewItemCell.self)
        let nib: UINib = UINib(nibName: nibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    private func addData() {
        let sliderData = [
            "https://picsum.photos/seed/picsum/200/300",
            "https://picsum.photos/seed/picsum/200/300",
            "https://picsum.photos/seed/picsum/200/300",
            "https://picsum.photos/seed/picsum/200/300",
            "https://picsum.photos/seed/picsum/200/300"
        ]
        
        for (index, value) in sliderData.enumerated() {
            let s1 = Slider(id: index+1, name: value, imageURL: value, title: "Lorem ipsum dolor sit amet",address: "BURSA / Turkey")
            sliderDataList.append(s1)
        }
    
    }
    
    private func startAutoScrolling() {
    
        Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollingSetup), userInfo: nil, repeats: true)
    }
    
    @objc func scrollingSetup() {
        
        if index < sliderDataList.count - 1 {
            index = index + 1
        }
        else {
            index = 0
        }
        
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .right, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
   
}

extension HomeTableItemSliderCell: collectionV {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderDataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SliderCollectionViewItemCell.self), for: indexPath) as? SliderCollectionViewItemCell {
            let model = sliderDataList[indexPath.row]
            cell.prepareForSlideImage(with: model)
            cell.layer.cornerRadius = 12
            return cell
        }
        return UICollectionViewCell()
    }
    
}

