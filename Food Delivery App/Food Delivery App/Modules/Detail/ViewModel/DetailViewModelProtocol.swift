//
//  DetailViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 1.12.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate? {get set}
    var detail: FoodsResponseResult? {get set}
    var detailTableItems: [DetailTableItems] {get set}
    
    func getData()
    
    func addToCart(with url: String, params: [String: Any])
    
    func addToFavorites(with model: FoodsResponseResult)
    
}
