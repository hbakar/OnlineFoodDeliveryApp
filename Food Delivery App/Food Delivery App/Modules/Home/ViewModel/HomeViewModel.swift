//
//  HomeViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import Foundation
import Alamofire
import CoreData

class HomeViewModel: HomeViewModelProtocol {
 
    var foodItemDelegate: FoodTableViewCellDelegate?
    
    let context = appDelegate.persistentContainer.viewContext
    
    var cartFoodList: [CartFoodResponseResult] = []
    
    var searchList: [FoodsResponseResult] = []
    
    var sliderList: [Slider] = []
    
    var categoryList: [Category] = []
   
    var homeTableItems: [HomeTableItem] = []
    
    weak var delegate: HomeViewModelDelegate?
    
    var isSearch = Bool()
    
    var foodList: [FoodsResponseResult] = []
    
    var cardResponse: CartResponse?
    
    private let service: HomeDataProviderProtocol
    
    init(service: HomeDataProviderProtocol) {
        self.service = service
    }
    
    func addToFavorites(with model: FoodsResponseResult) {
       let favori = FoodModel(context: context)
        favori.id = model.id ?? "0"
        favori.name = model.name ?? ""
        favori.imagePath = Constants.getFoodImage.appending(model.imagePath ?? "")
        favori.price = model.price ?? "0"
        appDelegate.saveContext()
        self.delegate?.notify(.didAddToFavorites)
    }
    
    func getCartFoodList(with url: String, params: Alamofire.Parameters) {
        let params = ["kullanici_adi":"huseyinbakar"]
        service.getAllFoodsFromCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cartFoodList = success.sepet_yemekler ?? []
                self?.delegate?.notify(.didFetchCartFood)
            case .failure(let failure):
                self?.delegate?.notify(.foodCartFetchFailed(failure))
            }
        }
    }
    
    func addToCart(with url: String, params: [String: Any]) {
        service.addToCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cardResponse = success
                self?.delegate?.notify(.didAddToCart)
            case .failure(let failure):
                self?.delegate?.notify(.addToCartFailed(failure))
            }
        }
    }
    
    func getAllFoods(with url: String) {
        service.getAllFoods(with: url) { [weak self] results in
            switch results {
            case .success(let success):
                if let list = success.yemekler {
                    
                    self?.foodList = list
                    self?.homeTableItems.append(.productsTableItem)
                    self?.delegate?.notify(.didFetchFoodsList)
                    
                }
            case .failure(let failure):
                self?.delegate?.notify(.fetchFailedFoods(failure))
            }
        }
    }
    
    func getCategoryItems() {
        categoryList = [Category(id: 1, name: "Makarnalar"),Category(id: 2, name: "Et Yemekleri"),Category(id: 3, name: "Çorba Çeşitleri"),
            Category(id: 4, name: "Deniz Ürünleri "),
                        Category(id: 5, name: "Sebze Yemekleri"),
                        Category(id: 6, name: "Salatalar"),
                        Category(id: 7, name: "Hamur İşleri"),
                        Category(id: 8, name: "Kahvaltı"),
                        Category(id: 9, name: "Tatlılar"),
                        Category(id: 10, name: "Atıştırmalıklar"),
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
    case didAddToCart
    case addToCartFailed(Error)
    case didFetchCartFood
    case foodCartFetchFailed(Error)
    case didAddToFavorites
    case AddToCartFailed(Error)
}

enum HomeTableItem {
    case sliderTableItem
    case categoryTableItem
    case productsTableItem
}
