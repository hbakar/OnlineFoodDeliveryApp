//
//  ChatViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Lottie

final class ChatViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
     
        showAnimation()
    }
    
    private func showAnimation() {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("loading")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        
        animationView.loopMode = .loop
        view.addSubview(animationView)
        
        animationView.play()
    }

}

extension ChatViewController {
    
}
