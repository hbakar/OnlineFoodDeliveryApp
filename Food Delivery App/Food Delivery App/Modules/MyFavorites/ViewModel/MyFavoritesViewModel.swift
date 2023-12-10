//
//  MyFavoritesViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 8.12.2023.
//

import Foundation

class MyFavoritesViewModel: MyFavoritesViewModelProtocol {
    
    weak var delegate: MyFavoritesViewModelDelegate?
    var foodList: [FoodModel] = []
    let context = appDelegate.persistentContainer.viewContext
    
    func getData() {
        do {
            foodList = try context.fetch(FoodModel.fetchRequest())
            self.delegate?.notify(.didFetchFavoriteList)
        }
        catch {
            print(error.localizedDescription)
            self.delegate?.notify(.fetchFailed(error.localizedDescription as! Error))
        }
    }
    
    func removeFood(with model: FoodModel) {
        do {
            context.delete(model)
            appDelegate.saveContext()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}

protocol MyFavoritesViewModelDelegate: AnyObject {
    func notify(_ event: MyFavoritesViewModelEvents)
}

enum MyFavoritesViewModelEvents {
    case didFetchFavoriteList
    case fetchFailed(Error)
}
