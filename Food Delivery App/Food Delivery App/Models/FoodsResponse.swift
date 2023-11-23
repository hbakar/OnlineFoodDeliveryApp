//
//  FoodsResponse.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import Foundation

struct FoodsResponse: Decodable {
    let yemekler: [FoodsResponseResult]?
    let success: Int?
}

struct FoodsResponseResult: Decodable {
    let id: String?
    let name: String?
    let imagePath: String?
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "yemek_id";
        case name = "yemek_adi";
        case imagePath = "yemek_resim_adi";
        case price = "yemek_fiyat";
    }
}
