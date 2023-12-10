//
//  MyFavoritesViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit
import Alamofire
import Lottie

final class MyFavoritesViewController: UIViewController {
 
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var viewModel: MyFavoritesViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        registerTableViewCell()
        registerTableView()
        viewModel?.delegate = self
        viewModel?.getData()
    }
    
    private func showAnimation() {
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named("notFound")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = favoriteTableView.center
        
        animationView.animationSpeed = 1.5
        animationView.loopMode = .loop
        self.favoriteTableView.backgroundView = animationView
        animationView.play()
    }
  
    @IBAction func btnCloseClicked(_ sender: Any) 
    {
        self.dismiss(animated: true)
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile-circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func tests(){
        
    }
    
    private func control() {
        if let count = viewModel?.foodList.count {
            
            if count == 0 {
                showAnimation()
                DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                    self.dismiss(animated: true)
                }
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        control()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getData()
    }
    
    private func registerTableView() {
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        let nibName = String(describing: FavoriteItemTableCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        favoriteTableView.register(nib, forCellReuseIdentifier: nibName)
    }
}

extension MyFavoritesViewController: tableV {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.foodList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteItemTableCell.self), for: indexPath) as? FavoriteItemTableCell else { return UITableViewCell() }
        
        guard let model = self.viewModel?.foodList[indexPath.row] else { return UITableViewCell() }
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.prepareForFavoriteItem(with: model)
        return cell
    }
}

extension MyFavoritesViewController: MyFavoritesViewModelDelegate {
    
    func notify(_ events: MyFavoritesViewModelEvents) {
        
        switch events {
        case .didFetchFavoriteList:
            DispatchQueue.main.async {
                self.favoriteTableView.dataSource = self
                self.favoriteTableView.reloadData()
            }
        case .fetchFailed(let error):
            self.favoriteTableView.dataSource = nil
            print(error.localizedDescription)
        }
    }
}

extension MyFavoritesViewController: FavoriteItemTableCellDelegate {
    
    func didClickedDeleteButton(indexPath: IndexPath) {
        
        showConfirmationAlert(title: "Warning", message: "Are you sure you want to delete?") { b in
            if b == true
            {
                if let item = self.viewModel?.foodList[indexPath.row] {
                    self.viewModel?.removeFood(with: item)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
                        self.viewModel?.getData()
                        self.control()
                    }
                }
            }
        }
        
    }
}
    
   
