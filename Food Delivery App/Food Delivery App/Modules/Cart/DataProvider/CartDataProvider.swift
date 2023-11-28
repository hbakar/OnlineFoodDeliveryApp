//
//  CartDataProvider.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 25.11.2023.
//

import Foundation
import Alamofire

final class CartDataProvider: CartDataProviderProtocol {
    
    func getAllFoodsFromCart(with url: String, params: Parameters, completion: @escaping (Result<CartFoodResponse, Error>) -> ()) {
        ServiceManager.shared.post(urlString: url, params: params, completion: completion)
    }
}
