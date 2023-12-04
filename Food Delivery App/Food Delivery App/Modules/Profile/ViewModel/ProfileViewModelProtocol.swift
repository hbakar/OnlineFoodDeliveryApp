//
//  ProfileViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    var profileMenuList: [Profile] {get set}
    var delegate: ProfileViewModelDelegate? {get set}
    
    func getProfile()
}


