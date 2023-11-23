//
//  HomeViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate? {get set}
    
    var foodList: [FoodsResponseResult] {get set}
    
    func getSliderItems()
    
    func getAllFoods(with url: String) 
}
