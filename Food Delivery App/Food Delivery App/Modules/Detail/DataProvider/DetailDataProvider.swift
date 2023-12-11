//
//  DetailDataProvider.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 11.12.2023.
//

import Foundation

class DetailDataProvider: DetailDataProviderProtocol {
    
    func addToCart(with urlString: String,params: [String: Any], completion: @escaping(Result<CartResponse, Error>) ->()) {
        ServiceManager.shared.post(urlString: urlString, params: params, completion: completion)
    }
}
