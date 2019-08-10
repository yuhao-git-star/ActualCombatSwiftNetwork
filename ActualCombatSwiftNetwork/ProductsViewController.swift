//
//  ProductsViewController.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/8/10.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import UIKit
import PKCHelper

class ProductsViewController: UITableViewController {

    private let cellId = "cellId"
    lazy var products: [Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = ProductsAPIServices.shared.fetchProducts().done { (products) in
            PKCLogger.shared.debug(products)
            self.products = products
            }.catch({ (_) in
                // 錯誤處理
            }).finally {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = products[indexPath.row].name
        
        return cell
    }
}
