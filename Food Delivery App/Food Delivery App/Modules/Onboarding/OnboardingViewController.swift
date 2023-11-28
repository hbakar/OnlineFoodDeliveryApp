//
//  OnboardingViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 24.11.2023.
//

import UIKit

final class OnboardingViewController: UIViewController, collectionV {
   
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == slides.count - 1 {
                btnNext.setTitle("Get Started", for: .normal)
            } else {
                btnNext.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       registerCell()
       registerCollection()
    }
    
    private func getData(){
        slides = [OnboardingSlide(title: "appAdi", description: "onboard1desc", image: UIImage(named: "slide01")!),OnboardingSlide(title: "onboard2title", description: "onboard2desc", image: UIImage(named: "slide02")!),OnboardingSlide(title: "onboard3title", description: "onboard3desc", image: UIImage(named: "slide03")!)]
    }
    
    private func registerCell() {
        let nibName = String(describing: OnboardingCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
    }
    
    private func registerCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       return UICollectionViewCell()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
           
            UserDefaults.standard.set(true, forKey: "onboardAcildiMi")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
                
                let mainViewController = MainTabController()
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true, completion: nil)
            }
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}



extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
