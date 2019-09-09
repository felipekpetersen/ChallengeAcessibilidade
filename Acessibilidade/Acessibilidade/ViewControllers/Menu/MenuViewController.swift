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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numberOfCategorysLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    public var restaurant = RestaurantCodable()
    public var menu = MenuCodable()
    var viewModel = MenuViewModel()
    let menuCell = "MenuTableViewCell"
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCornerView()
        setupLabels()
        viewModel.menu = menu
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.layoutIfNeeded()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: menuCell, bundle: nil), forCellReuseIdentifier: menuCell)
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: menuCell, for: indexPath) as? MenuTableViewCell
        let category = self.viewModel.getCategory(row: indexPath.row)
        cell?.setupCell(category: category, isOpen: self.selectedIndex == indexPath.row ? true : false, restaurantName: restaurant.name ?? String())
        cell?.setupCornerView(cornerRadius: 5)
        cell?.layoutSubviews()
        cell?.layoutIfNeeded()
        cell?.selectionStyle = .none
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.selectedIndex == indexPath.row {
            self.selectedIndex = nil
        } else {
            self.selectedIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: .fade)
        self.tableView.endUpdates()
    }
}

extension MenuViewController:  MenuTableViewCellDelegate {
    func receivePlate(restaurantName: String, plate: PlateCodable) {
        let vc = SelectPlateModalViewController()

        vc.restaurantName = restaurantName
        vc.plate = plate
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
}

