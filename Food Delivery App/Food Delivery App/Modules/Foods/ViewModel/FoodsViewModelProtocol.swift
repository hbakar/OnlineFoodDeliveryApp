//
//  FoodsViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation

protocol FoodsViewModelProtocol {
    
    var cardResponse: CartResponse? {get set}
    
    var delegate: FoodViewModelDelegate? {get set}
    
    var foodList: [FoodsResponseResult] {get set}
    
    var searchList: [FoodsResponseResult] {get set}
    
    var isSearch: Bool {get set}
    
    func getAllFoods(with url: String) 
}
