//
//  CardFoodResponse.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 27.11.2023.
//

import Foundation

struct CartFoodResponse: Codable {
    let sepet_yemekler: [CartFoodResponseResult]?
    let success: Int?
}

struct CartFoodResponseResult: Codable {
    let sepet_yemek_id: String?
    let yemek_adi: String?
    let yemek_resim_adi: String?
    let yemek_fiyat: String?
    var yemek_siparis_adet: String?
    let kullanici_adi: String?
}


