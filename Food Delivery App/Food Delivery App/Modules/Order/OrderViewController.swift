//
//  CartViewController.swift
//  Food Delivery App
//
//  Created by Hüseyin BAKAR on 23.11.2023.
//

import UIKit

final class OrderViewController: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "profile-circle")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(tests))
    }
    
    @objc func tests(){
        
    }

}

extension OrderViewController: tableV {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
        let cell = UITableViewCell()
        
        
        /*
         guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: OrderItemTableCell.self), for: indexPath) as? OrderItemTableCell else { return UITableViewCell() }
         */
      //  cell.prepareForCartItem(with: "")
        
        return cell
    }
}
