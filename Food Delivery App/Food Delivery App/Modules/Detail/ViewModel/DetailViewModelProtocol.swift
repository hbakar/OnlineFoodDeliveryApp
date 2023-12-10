//
//  DetailViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 1.12.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var detail: FoodsResponseResult? {get set}
    var detailTableItems: [DetailTableItems] {get set}
}
