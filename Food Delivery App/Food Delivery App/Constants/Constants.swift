//
//  Constants.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import Foundation

struct Constants {
    static let baseURL = "http://kasimadalan.pe.hu"
    static let path = "/yemekler"
    static let allFoodsURL = "\(baseURL)\(path)/tumYemekleriGetir.php"
    static let allFoodsFromCartURL = "\(baseURL)\(path)/sepettekiYemekleriGetir.php"
    static let addToCartURL = "\(baseURL)\(path)/sepeteYemekEkle.php"
    static let removeFromCartURL = "\(baseURL)\(path)/sepettenYemekSil.php"
}
