//
//  CartViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 27.11.2023.
//

import Foundation
import Alamofire

protocol CartViewModelProtocol {
    
    var delegate: CartViewModelDelegate? {get set}
    
    var cartFoodList: [CartFoodResponseResult] {get set}
    
    func getCartFoodList(with url:String, params: Parameters)
}
