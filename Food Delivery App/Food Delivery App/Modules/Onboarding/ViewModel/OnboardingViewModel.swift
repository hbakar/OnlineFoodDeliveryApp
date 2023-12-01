//
//  OnboardingViewModel.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 29.11.2023.
//

import Foundation
import UIKit

final class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var delegate: OnboardingViewModelDelegate?
    var slideList: [OnboardingSlide] = []
    
    func getData() {
        slideList = [OnboardingSlide(title: "Fresh Food", description: "We make it simple to find the food you crave. Enter your address and let us do the rest.", image: UIImage(named: "o1")!),OnboardingSlide(title: "Fast Delivery", description: "When ou orderat Street, we'll hook you up with exclusive coupons, specials and rewards", image: UIImage(named: "o2")!),OnboardingSlide(title: "Easy Payment", description: "we make ordering fast, simple and free - no matter if you order online or cash.", image: UIImage(named: "o3")!)]
        self.delegate?.notify(.didFetchOnboardingList)
    }
}

protocol OnboardingViewModelDelegate: AnyObject {
    func notify(_ event: OnboardingViewModelEvent)
}

enum OnboardingViewModelEvent{
    case didFetchOnboardingList
    case fetchFailed(Error)
}
