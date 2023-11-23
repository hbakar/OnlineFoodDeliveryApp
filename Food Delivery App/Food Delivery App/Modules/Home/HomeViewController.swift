//
//  HomeViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit

final class HomeViewController: UIViewController, tableV {

    @IBOutlet weak var homeTableView: UITableView!
    
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableViewCell()
        setupTableView()
        
        viewModel?.delegate = self
        viewModel?.getAllFoods(with: Constants.allFoodsURL)
    }
    
    private func setupTableViewCell() {
        let nibName = String(describing: HomeTableItemSliderCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        
        homeTableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    private func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }

}


extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}


extension HomeViewController: HomeViewModelDelegate {
  
    func notify(_ event: HomeViewModelEvents) {
        switch event {
        case .didFetchFoodsList:
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        case .fetchFailedFoods(let error):
            print(error.localizedDescription)
        }
    }
    
    
}
