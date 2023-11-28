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

        registerTableViewCell()
        registerTableView()
    }
    
    private func registerTableView() {
        orderTableView.delegate = self
        orderTableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        /*
         let nibName = String(describing: OrderItemTableCell.self)
         let nib = UINib(nibName: nibName, bundle: .main)
         orderTableView.register(nib, forCellReuseIdentifier: nibName)
         */
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
