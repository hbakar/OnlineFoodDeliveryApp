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
    var categoryList: [Category] {get set}
    
    var homeTableItems: [HomeTableItem] {get set}
    
    var sliderList: [Slider] {get set}
    
    func getSliderItems()
    
    func getCategoryItems()
    
    func getAllFoods(with url: String) 
}
