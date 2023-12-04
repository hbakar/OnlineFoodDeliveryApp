//
//  ProfileViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 4.12.2023.
//

import Foundation

final class ProfileViewModel: ProfileViewModelProtocol {
    var profileMenuList: [Profile] = []
    
    var delegate: ProfileViewModelDelegate?
    
    func getProfile() {
        profileMenuList = [Profile(image: "user-square", title: "Personal Information"),Profile(image: "save-minus", title: "My Favorites"),Profile(image: "setting", title: "Settings"),Profile(image: "logout", title: "Exit")]
        self.delegate?.notify(.didFetchProfile)
    }
}

protocol ProfileViewModelDelegate: AnyObject {
    func notify(_ event: ProfileViewModelEvents)
}

enum ProfileViewModelEvents {
    case didFetchProfile
    case fetchFailed(Error)
}
