//
//  HomeDataProviderProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

protocol HomeDataProviderProtocol {
    func getAllFoods(with url: String, completion:@escaping(Result<FoodsResponse, AFError>) ->())
    
    func addToCart(with urlString: String,params: [String: Any], completion: @escaping(Result<CartResponse, Error>) ->())
    
    func getAllFoodsFromCart(with url:String,params: Parameters, completion: @escaping(Result<CartFoodResponse, Error>) ->())
}
 
