//
//  HomeViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

protocol HomeViewModelProtocol {
    
    var foodItemDelegate: FoodTableViewCellDelegate? {get set}
    
    var delegate: HomeViewModelDelegate? {get set}
    
    var foodList: [FoodsResponseResult] {get set}
    
    var cartFoodList: [CartFoodResponseResult] {get set}
    
    var searchList: [FoodsResponseResult] {get set}
    
    var isSearch: Bool {get set}
    
    var cardResponse: CartResponse? {get set}
    
    var categoryList: [Category] {get set}
    
    var homeTableItems: [HomeTableItem] {get set}
    
    var sliderList: [Slider] {get set}
    
    func getSliderItems()
    
    func getCategoryItems()
    
    func getAllFoods(with url: String) 
    
    func getCartFoodList(with url:String, params: Parameters)
    
    func addToCart(with url: String, params: [String: Any])
    
    func addToFavorites(with model: FoodsResponseResult)
}
