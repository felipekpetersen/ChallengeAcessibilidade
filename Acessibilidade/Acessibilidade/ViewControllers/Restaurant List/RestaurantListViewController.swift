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
    
    let viewModel = RestaurantListViewModel()
    let pratoCell = "RestaurantCellTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLabel()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: pratoCell, bundle: nil), forCellReuseIdentifier: pratoCell)
        self.tableView.separatorStyle = .none
    }
    
    func setupLabel(){
        self.testeLabel.text = "Nome do categora"
    }
 
}

extension RestaurantListViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: pratoCell, for: indexPath) as! RestaurantCellTableViewCell
        cell.setup(color: .gray, text: "Nome do restaurante")
        return cell
    }
}
