//
//  DetailViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 24.11.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
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
        
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension DetailViewController: tableV {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

