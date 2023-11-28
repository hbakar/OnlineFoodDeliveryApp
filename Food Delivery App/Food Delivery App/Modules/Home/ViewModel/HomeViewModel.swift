//
//  HomeViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire

class HomeViewModel: HomeViewModelProtocol {
    
    var sliderList: [Slider] = []
    
    var categoryList: [Category] = []
   
    var homeTableItems: [HomeTableItem] = []
    
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
    
    func getCategoryItems() {
        categoryList = [Category(id: 1, name: "Sandwiches"),Category(id: 2, name: "Grill"),Category(id: 3, name: "Salads"),
            Category(id: 4, name: "Drinks"),
                        Category(id: 5, name: "Chips")
        ]
        
        homeTableItems.append(.categoryTableItem)
        
        self.delegate?.notify(.didFetchCategoryList)
    }
    
    func getSliderItems() {
      
        homeTableItems.append(.sliderTableItem)
        
        sliderList = [Slider(id: 1, name: "slide002",imageURL: "https://placehold.co/400x200/png",title: "Lorem ipsum dolor sit amet",address: "Istanbul / TURKEY"),Slider(id: 2, name: "slide002",imageURL: "https://placehold.co/400x200/png",title: "Lorem ipsum dolor sit amet",address: "Istanbul / TURKEY"),Slider(id: 3, name: "slide002",imageURL: "https://placehold.co/400x200/png",title: "Lorem ipsum dolor sit amet",address: "Istanbul / TURKEY")]
        
        self.delegate?.notify(.didFetchSliderList)
    }
}

protocol HomeViewModelDelegate: AnyObject {
    func notify(_ event: HomeViewModelEvents)
}

enum HomeViewModelEvents {
    case didFetchFoodsList
    case fetchFailedFoods(Error)
    case didFetchSliderList
    case fetchFailedSlider(Error)
    case didFetchCategoryList
    case fetchFailedCategory(Error)
}

enum HomeTableItem {
    case sliderTableItem
    case categoryTableItem
    case productsTableItem
}
