//
//  HomeViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

class HomeViewModel: HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate?
    
    var foodList: [FoodsResponseResult] = []
    
    private let service: HomeDataProviderProtocol
    
    init(service: HomeDataProviderProtocol) {
        self.service = service
    }
    
    func getAllFoods(with url: String) {
        service.getAllFoods(with: url) { [weak self] results in
            switch results {
            case .success(let success):
                if let list = success.yemekler {
                    self?.foodList = list
                    self?.delegate?.notify(.didFetchFoodsList)
                }
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailedFoods(failure))
            }
        }
    }
    
    func getSliderItems() {
        
    }
}

protocol HomeViewModelDelegate: AnyObject {
    func notify(_ event: HomeViewModelEvents)
}

enum HomeViewModelEvents {
    case didFetchFoodsList
    case fetchFailedFoods(Error)
}

enum HomeTableItems {
    case sliderTableItem
    case productsTableItem
}
