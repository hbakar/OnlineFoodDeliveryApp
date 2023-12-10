//
//  MyFavoritesViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 8.12.2023.
//

import Foundation
import CoreData



protocol MyFavoritesViewModelProtocol {
    
    var delegate: MyFavoritesViewModelDelegate? {get set}
    
    var foodList: [FoodModel] {get set}
    
    func getData()
    
    func removeFood(with model: FoodModel)
}
