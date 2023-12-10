//
//  DetailViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 1.12.2023.
//

import Foundation

final class DetailViewModel: DetailViewModelProtocol {
    
    init(detail: FoodsResponseResult?) {
        self.detail = detail
        self.detailTableItems.append(.detailImageItem)
        self.detailTableItems.append(.detailTitleItem)
        self.detailTableItems.append(.detailPriceItem)
        self.detailTableItems.append(.detailQuantity)
        self.detailTableItems.append(.detailAddToCart)
    }
    
    var detail: FoodsResponseResult?
    var detailTableItems: [DetailTableItems] = []
}

enum DetailTableItems {
    case detailImageItem
    case detailTitleItem
    case detailPriceItem
    case detailQuantity
    case detailAddToCart
}
