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
    
    @IBAction func btnSearchClicked(_ sender: Any) {
      
        if let txt = self.searchText.text {
           
            if txt.isEmpty == false {
                viewModel?.isSearch = true
                
                if let lst = self.viewModel?.foodList.filter({$0.name?.lowercased().contains(txt.lowercased()) == true }) {
                    viewModel?.searchList = lst
                    
                    DispatchQueue.main.async {
                        self.homeTableView.reloadData()
                    }
                }
            }
            else {
                viewModel?.isSearch = false
            }
        }
    }
    
    var viewModel: HomeViewModelProtocol?
    
    fileprivate func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile-circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
    }
    
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
        
        setNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let params : [String: Any] = ["kullanici_adi": "huseyinbakar"]
        viewModel?.getCartFoodList(with: Constants.allFoodsFromCartURL, params: params)
    }
 
    
    @objc func tests() {
        print("test")
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
        
        // foods cell
        
        let nibNameFood = String(describing: FoodTableViewCell.self)
        let nibFood = UINib(nibName: nibNameFood, bundle: .main)
        homeTableView.register(nibFood, forCellReuseIdentifier: nibNameFood)
    }
    
    private func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
    }
    
    private func getCartItemCount() {
        
        DispatchQueue.main.async {
            if let cnt = self.tabBarController?.tabBar.items {
               
                var count = 0
                if let cnt2 = cnt[2] as? UITabBarItem {
                    if UserDefaults.standard.integer(forKey: "cookieFoodCount") > 0 {
                       UserDefaults.standard.integer(forKey: "cookieFoodCount")
                        UserDefaults.standard.setValue(count, forKey: "cookieFoodCount")
                        Singleton.shared.cartItemCount = count
                    }
                    else {
                        Singleton.shared.cartItemCount = count
                        UserDefaults.standard.setValue(count, forKey: "cookieFoodCount")
                    }
                  
                   // Singleton.shared.cartItemCount = Singleton.shared.cartItemCount + 1
                    cnt2.badgeValue = String(Singleton.shared.cartItemCount)
                }
            }
        }
        
    }
    
    private func setCartItemCount() {
        
        DispatchQueue.main.async {
            if let cnt = self.tabBarController?.tabBar.items {
               
                var count = 0
                if let cnt2 = cnt[2] as? UITabBarItem {
                    if UserDefaults.standard.integer(forKey: "cookieFoodCount") > 0 {
                       UserDefaults.standard.integer(forKey: "cookieFoodCount")
                        UserDefaults.standard.setValue(count, forKey: "cookieFoodCount")
                        Singleton.shared.cartItemCount = count
                    }
                    else {
                        Singleton.shared.cartItemCount = Singleton.shared.cartItemCount + 1
                        UserDefaults.standard.setValue(count, forKey: "cookieFoodCount")
                    }
                    cnt2.badgeValue = String(Singleton.shared.cartItemCount)
                }
            }
        }
        
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
            return 1
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodTableViewCell.self)) as? FoodTableViewCell {
                if viewModel?.isSearch == true {
                    cell.foodList = self.viewModel?.searchList ?? []
                }
                else {
                    cell.foodList = self.viewModel?.foodList ?? []
                }
                cell.viewModel = viewModel
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if indexPath.section == 0 {
            return 200
        }
        
        if indexPath.section == 1 {
            return 60 // 36  44
        }
        
        return self.homeTableView.frame.size.height - 200
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
        case .didAddToCart:
            setCartItemCount()
        case .addToCartFailed(let error):
            print(error.localizedDescription)
        case .didFetchCartFood:
            DispatchQueue.main.async {
                let count = self.viewModel?.cartFoodList.count ?? 0
                UserDefaults.standard.setValue(count, forKey: "cookieFoodCount")
            }
        case .foodCartFetchFailed(let error):
            print(error.localizedDescription)
        }
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      
    }
}
