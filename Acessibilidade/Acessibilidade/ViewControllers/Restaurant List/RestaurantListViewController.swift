//
//  RestaurantListViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {

    @IBOutlet weak var testeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
 
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
