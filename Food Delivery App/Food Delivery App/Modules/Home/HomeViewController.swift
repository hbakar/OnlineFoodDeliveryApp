//
//  HomeViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 22.11.2023.
//

import UIKit

final class HomeViewController: UIViewController, tableV {
    @IBOutlet weak var btnRemove: UIButton!
    
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var searchText: UITextField!
    
    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupTableViewCell()
        setupTableView()
        
        searchText.delegate = self
        viewModel?.delegate = self
        viewModel?.getSliderItems()
        viewModel?.getCategoryItems()
        viewModel?.getAllFoods(with: Constants.allFoodsURL)
    }
    
    @IBAction func btnRemoveClicked(_ sender: Any) {
        self.searchText.text = ""
    }
    
    private func setupTableViewCell() {
        let nibName = String(describing: HomeTableItemSliderCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        homeTableView.register(nib, forCellReuseIdentifier: nibName)
        
        
        // category cell
        
        let nibNameCat = String(describing: HomeCategoryCell.self)
        let nibCat = UINib(nibName: nibNameCat, bundle: .main)
        homeTableView.register(nibCat, forCellReuseIdentifier: nibNameCat)
    }
    
    private func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
}


extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sectionCount = viewModel?.homeTableItems.count
        else { return 0 }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sliderListCount = viewModel?.sliderList, let tableItems = viewModel?.homeTableItems[section] else { return 0}
        
        switch tableItems {
        case .sliderTableItem:
            return 1
        case .categoryTableItem:
            return 1
        case .productsTableItem:
            return 0
       
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableItem = viewModel?.homeTableItems[indexPath.section]
        else { return UITableViewCell() }
        
        switch tableItem {
        case .sliderTableItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeTableItemSliderCell.self)) as? HomeTableItemSliderCell {
                //   cell.sliderData = self.viewModel?.sliderList ?? []
                return cell
            }
        case .categoryTableItem:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomeCategoryCell.self)) as? HomeCategoryCell {
                cell.categoryList = self.viewModel?.categoryList ?? []
                return cell
            }
        case .productsTableItem:
            print(123)
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if indexPath.section == 0 {
            return 200
        }
        
        if indexPath.section == 1 {
            return 68 // 36
        }
        
        return self.homeTableView.frame.size.height - 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func changeColor(itemApperance: UITabBarItemAppearance) {
        itemApperance.selected.iconColor = UIColor(named: "primaryColor")
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
        case .didFetchSliderList:
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        case .fetchFailedSlider(_):
            print("no data returned!")
        case .didFetchCategoryList:
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        case .fetchFailedCategory(let error):
            print(error.localizedDescription)
        }
    }
    
    
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(textField.text)
    }
}
