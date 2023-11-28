//
//  FoodsViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation

class FoodsViewModel: FoodsViewModelProtocol {
   
    var cardResponse: CartResponse?
    
    var delegate: FoodViewModelDelegate?
    
    var foodList: [FoodsResponseResult] = []
    
    var searchList: [FoodsResponseResult] = []
    
    var isSearch: Bool = Bool()
    
    private let service: FoodsDataProviderProtocol
    
    init(service: FoodsDataProviderProtocol) {
        self.service = service
    }
    
    func addToCart(with url: String, params: [String: Any]) {
        service.addToCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cardResponse = success
                self?.delegate?.notify(.didAddToCart)
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailed(failure))
            }
        }
    }
    
    func getAllFoods(with url: String) {
        service.getAllFoods(with: url) { [weak self] results in
          
            switch results {
            case .success(let success):
                
                if let list = success.yemekler {
                    self?.foodList = list
                    self?.delegate?.notify(.didFetchFoodList)
                }
                
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailed(failure.localizedDescription as! Error))
            }
        }
    }
    
}

protocol FoodViewModelDelegate: AnyObject {
    func notify(_ event: FoodsViewModelEvents)
}

enum FoodsViewModelEvents {
    case didFetchFoodList
    case fetchFailed(Error)
    case didAddToCart
    case addToCartFailed(Error)
}


