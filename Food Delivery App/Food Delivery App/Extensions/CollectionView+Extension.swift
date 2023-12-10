//
//  CollectionView+Extension.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 5.12.2023.
//

import UIKit

extension UICollectionView {
    func registerNib(_ nibName: String, forCellReuseIdentifier identifier: String) {
        let nib = UINib(nibName: nibName, bundle: .main)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
