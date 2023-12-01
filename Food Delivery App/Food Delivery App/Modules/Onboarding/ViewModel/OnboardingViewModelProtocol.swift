//
//  OnboardingViewModelProtocol.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 29.11.2023.
//

import Foundation


protocol OnboardingViewModelProtocol {
    var delegate: OnboardingViewModelDelegate? {get set}
    var slideList: [OnboardingSlide] {get set}
    func getData()
}
