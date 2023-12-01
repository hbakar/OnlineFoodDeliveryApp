//
//  CartDataProviderProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 25.11.2023.
//

import Foundation
import Alamofire

protocol CartDataProviderProtocol {
    func getAllFoodsFromCart(with url:String,params: Parameters, completion: @escaping(Result<CartFoodResponse, Error>) ->())
    
    func removeFoodFromCart(with url: String, params: Parameters, completion: @escaping (Result<CartResponse, Error>) -> ())
}
