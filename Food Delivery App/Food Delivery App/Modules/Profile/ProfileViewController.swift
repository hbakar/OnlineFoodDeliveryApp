//
//  ProfileViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var viewModel: ProfileViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
        registerTableViewCell()
        registerTableView()
        self.navigationController?.navigationBar.isHidden = true
        viewModel?.delegate = self
        viewModel?.getProfile()
        
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.layer.borderColor = UIColor(white: 0.95, alpha: 1).cgColor
        containerView.layer.borderWidth = 1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func registerTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableViewCell(){
        let nibName = String(describing: ProfileTableItemCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
}

extension ProfileViewController: tableV {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableItemCell.self), for: indexPath) as? ProfileTableItemCell else {return UITableViewCell()}
        
        if let profileList = viewModel?.profileMenuList {
            cell.prepareForProfileItem(with: profileList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.profileMenuList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 1:
            let myFavoritesViewController = MyFavoritesViewController(nibName: String(describing: MyFavoritesViewController.self), bundle: .main)
          
            myFavoritesViewController.viewModel = MyFavoritesViewModel()
           
            myFavoritesViewController.modalPresentationStyle = .formSheet
            present(myFavoritesViewController,animated: true)
        case 2:
            let settingsViewController = SettingsViewController(nibName: String(describing: SettingsViewController.self), bundle: .main)
            settingsViewController.viewModel = SettingsViewModel()
        
            settingsViewController.modalPresentationStyle = .formSheet
            present(settingsViewController,animated: true)
        default:
            return
        }
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    func notify(_ event: ProfileViewModelEvents) {
        switch event {
        case .didFetchProfile:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .fetchFailed(let error):
            print(error.localizedDescription)
        }
    }
}
