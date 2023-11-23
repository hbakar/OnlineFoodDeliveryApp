//
//  HomeDataProviderProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

protocol HomeDataProviderProtocol {
    func getAllFoods(with url: String, completion:@escaping(Result<FoodsResponse, AFError>) ->())
}
 
