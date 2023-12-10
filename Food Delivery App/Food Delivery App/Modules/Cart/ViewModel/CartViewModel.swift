//
//  CartViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 27.11.2023.
//

import Foundation


final class CartViewModel: CartViewModelProtocol {
    
    weak var delegate: CartViewModelDelegate?
    
    var cartFoodList: [CartFoodResponseResult] = []
    
    var cardResponse: CartResponse?
    
    var quantity = 0
    
    private let service: CartDataProviderProtocol
    
    init(service: CartDataProviderProtocol) {
        self.service = service
    }
    
    func getCartFoodList(with url: String, params: [String: Any]) {
        service.getAllFoodsFromCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
             
                guard let liste = success.sepet_yemekler else { return }
                self?.cartFoodList = liste
                
                self?.delegate?.notify(.didFetchCartList)
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailed(failure))
            }
        }
    }
    
    func removeFoodFromCart(with url: String, params: [String: Any]) {
        service.removeFoodFromCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cardResponse = success
                self?.delegate?.notify(.removeFood)
            case .failure(let failure):
                self?.delegate?.notify(.removeFailed(failure))
            }
        }
    }
    
}

protocol CartViewModelDelegate: AnyObject {
    func notify(_ events: CartViewModelEvents)
}

enum CartViewModelEvents {
    case didFetchCartList
    case fetchFailed(Error)
    case removeFood
    case removeFailed(Error)
}
