//
//  OnboardingViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 10.12.2023.
//

import UIKit
import Lottie

final class OnboardingViewController: UIViewController, collectionV {
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == (viewModel?.slideList.count ?? 0) - 1 {
                btnAllow.setTitle("Get Started", for: .normal)
            } else {
                btnAllow.setTitle("Next", for: .normal)
            }
        }
    }
    
    @IBOutlet weak var btnAllow: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
   var viewModel: OnboardingViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        registerCollection()
        viewModel?.delegate = self
        viewModel?.getData()
        pageControl.numberOfPages = viewModel?.slideList.count ?? 0
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
        return viewModel?.slideList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OnboardingCell.self), for: indexPath) as? OnboardingCell else {return UICollectionViewCell()}
       
        if let list = viewModel?.slideList {
            cell.prepareforOnboardItem(with: list[indexPath.row])
        }
        return cell
    }
    
    @IBAction func btnAllowClicked(_ sender: Any) {
        
        if currentPage == (viewModel?.slideList.count ?? 0) - 1 {
          
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

extension OnboardingViewController: OnboardingViewModelDelegate {
    
    func notify(_ event: OnboardingViewModelEvent) {
        switch event {
        case .didFetchOnboardingList:
            DispatchQueue.main.async {
                
                UserDefaults.standard.set(true, forKey: "onboardAcildiMi")
                
                DispatchQueue.main.async {
                    let mainViewController = MainTabController()
                    mainViewController.modalPresentationStyle = .fullScreen
                    self.present(mainViewController, animated: true, completion: nil)
                }
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        }
    }
}
