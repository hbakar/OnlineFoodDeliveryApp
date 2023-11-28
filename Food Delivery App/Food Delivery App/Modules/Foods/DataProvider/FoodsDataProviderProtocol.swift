//
//  FoodsDataProviderProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

protocol FoodsDataProviderProtocol {
    
    func getAllFoods(with urlString: String,completion: @escaping(Result<FoodsResponse, AFError>) ->())
    
    func addToCart(with urlString: String,params: [String: Any], completion: @escaping(Result<CartResponse, Error>) ->())
}
