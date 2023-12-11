//
//  DetailDataProviderProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 11.12.2023.
//

import Foundation

protocol DetailDataProviderProtocol {
    
    func addToCart(with urlString: String,params: [String: Any], completion: @escaping(Result<CartResponse, Error>) ->())
}
