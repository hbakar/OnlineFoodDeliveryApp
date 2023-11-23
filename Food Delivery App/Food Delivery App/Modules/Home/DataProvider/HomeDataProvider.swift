//
//  HomeDataProvider.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

final class HomeDataProvider: HomeDataProviderProtocol {
    func getAllFoods(with urlString: String, completion: @escaping (Result<FoodsResponse, AFError>) -> ()) {
        ServiceManager.shared.fetchRequest(urlString: urlString, completion: completion)
    }
}
