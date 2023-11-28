//
//  CartViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 27.11.2023.
//

import Foundation
import Alamofire


final class CartViewModel: CartViewModelProtocol {
    
    var delegate: CartViewModelDelegate?
   
    var cartFoodList: [CartFoodResponseResult] = []
    
    private let service: CartDataProviderProtocol
    
    init(service: CartDataProviderProtocol) {
        self.service = service
    }
    
    func getCartFoodList(with url: String, params: Parameters) {
        service.getAllFoodsFromCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cartFoodList = success.sepet_yemekler ?? []
                self?.delegate?.notify(.didFetchCartList)
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailed(failure))
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
}
