//
//  DetailViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 1.12.2023.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    
    
    var detail: FoodsResponseResult?
    var detailTableItems: [DetailTableItems] = []
    weak var delegate: DetailViewModelDelegate?
    var cardResponse: CartResponse?
    let context = appDelegate.persistentContainer.viewContext
    
    private let service: DetailDataProviderProtocol
    
    init(service: DetailDataProviderProtocol, detail: FoodsResponseResult) {
        self.service = service
        self.detail = detail
    }
    
    func getData() {
        detailTableItems.append(.detailImageItem)
        detailTableItems.append(.detailTitleItem)
        detailTableItems.append(.detailPriceItem)
        detailTableItems.append(.detailQuantity)
        self.delegate?.notify(.didFetchDetail)
    }
    
    func addToFavorites(with model: FoodsResponseResult) {
       let favori = FoodModel(context: context)
        favori.id = model.id ?? "0"
        favori.name = model.name ?? ""
        favori.imagePath = Constants.getFoodImage.appending(model.imagePath ?? "")
        favori.price = model.price ?? "0"
        appDelegate.saveContext()
        self.delegate?.notify(.didAddtoFavorites)
    }
    
    func addToCart(with url: String, params: [String: Any]) {
        service.addToCart(with: url, params: params) { [weak self] results in
            switch results {
            case .success(let success):
                self?.cardResponse = success
                self?.delegate?.notify(.didAddtoCart)
            case .failure(let failure):
                self?.delegate?.notify(.failedToAddtoCart(failure))
            }
        }
    }
    
    func addToFavorites() {
      /*
       if let item = vie {
           viewModel?.addToFavorites(with: item)
       }
       */
    }
}

protocol DetailViewModelDelegate: AnyObject {
    func notify(_ event: DetailViewModelEvents)
}

enum DetailViewModelEvents {
    case didFetchDetail
    case fetchFailed(Error)
    case didAddtoCart
    case failedToAddtoCart(Error)
    case didAddtoFavorites
    case failedAddtoFavorites(Error)
}

enum DetailTableItems {
    case detailImageItem
    case detailTitleItem
    case detailPriceItem
    case detailQuantity
}
