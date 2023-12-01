//
//  DetailViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 24.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var viewModel: DetailViewModelProtocol?
    
    var imageView: UIImageView!
    
    var chosenFood: FoodsResponseResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewCell()
        setupTableView()
    }
    
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    private func setupTableViewCell() {
        
        let nibName = String(describing: DetailItemImageViewCell.self)
        let nib = UINib(nibName: nibName, bundle: .main)
        detailTableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension DetailViewController: tableV {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

