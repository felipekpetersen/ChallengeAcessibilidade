//
//  MenuViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var categorysTableView: UITableView!
    @IBOutlet weak var numberOfCategorysLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    public var restaurant = RestaurantCodable()
    public var menu = MenuCodable()
    var viewModel = MenuViewModel()
    let menuCell = "MenuTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCornerView()
        setupLabels()
        viewModel.menu = menu
        
    }
    
    func setupTableView() {
        self.categorysTableView.delegate = self
        self.categorysTableView.dataSource = self
        self.categorysTableView.separatorStyle = .none
        categorysTableView.register(UINib(nibName: menuCell, bundle: nil), forCellReuseIdentifier: menuCell)
    }
    
    func setupCornerView() {
        cornerView.layer.cornerRadius = 22
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cornerView.addShadow(color: .black, opacity: 1, offSet: .zero, radius: 30)
        
    }
    
    func setupLabels() {
        restaurantNameLabel.text = restaurant.name
        categoryNameLabel.text = menu.name
        guard let numberOfCategorys = restaurant.menus?.count else {return}
        numberOfCategorysLabel.text = "Há \(numberOfCategorys) categorias de pratos"
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.categorysTableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as? MenuTableViewCell
        var category = self.viewModel.getCategory(row: indexPath.row)
        cell?.setupCell(category: category)
        cell?.setupCornerView(cornerRadius: 5)
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}
