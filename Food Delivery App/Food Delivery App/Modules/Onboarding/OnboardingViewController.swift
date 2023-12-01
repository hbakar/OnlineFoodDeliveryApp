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
    
    var viewModel: OnboardingViewModelProtocol?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            
            if currentPage == (viewModel?.slideList.count ?? 0) - 1 {
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
        return self.viewModel?.slideList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:OnboardingCell.self), for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        guard let model = self.viewModel?.slideList[indexPath.row] else { return UICollectionViewCell()}
        cell.prepareforOnboardItem(with: model)
        return cell
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        if currentPage == (viewModel?.slideList.count ?? 0 ) - 1 {
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

extension OnboardingViewController: OnboardingViewModelDelegate {
    func notify(_ event: OnboardingViewModelEvent) {
        switch event {
        case .didFetchOnboardingList:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        }
    }
}
