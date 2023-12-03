//
//  HomeDataProvider.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

final class HomeDataProvider: HomeDataProviderProtocol {
    func getAllFoods(with urlString: String, completion: @escaping (Result<FoodsResponse, AFError>) -> ()) {
        ServiceManager.shared.fetchRequest(urlString: urlString, completion: completion)
    }
    
    func addToCart(with urlString: String,params: [String: Any], completion: @escaping(Result<CartResponse, Error>) ->()) {
        ServiceManager.shared.post(urlString: urlString, params: params, completion: completion)
    }
    
    func getAllFoodsFromCart(with url: String, params: [String: Any], completion: @escaping (Result<CartFoodResponse, Error>) -> ()) {
        ServiceManager.shared.post(urlString: url, params: params, completion: completion)
    }
}
