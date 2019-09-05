//
//  NearRestaurantViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit

class NearRestaurantViewController: UIViewController {


    @IBOutlet weak var nearRestaurantLabel: UILabel!
    @IBOutlet weak var nearRestaurantTableView: UITableView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var categoryPhoto: UIImageView!
    @IBOutlet weak var defaultCategoryLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let nearRestaurantCell = "NearRestaurantTableViewCell"
    let viewModel = NearRestaurantViewModel()
    var categoryName = ""
    var restaurants: [RestaurantCodable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.categoryName = self.categoryName
        self.viewModel.restaurants = self.restaurants
        setupTableView()
        setupCategorytLabel()
        setupCategoryPhoto()
        setupCornerView()
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        
    }

    func setupTableView() {
        self.nearRestaurantTableView.delegate = self
        self.nearRestaurantTableView.dataSource = self
        self.nearRestaurantTableView.separatorStyle = .none
        nearRestaurantTableView.register(UINib(nibName: nearRestaurantCell, bundle: nil), forCellReuseIdentifier: nearRestaurantCell)
    }

    func setupCategorytLabel() {
        categoryLabel.text = self.viewModel.getRestaurantsCategory(index: 0)
        defaultCategoryLabel.text = "Categoria"
        nearRestaurantLabel.text = "\(self.viewModel.restaurants.count) restaurantes próximos"
    }
    
    
    func setupCategoryPhoto() {
    }
    
    func setupCornerView() {
        cornerView.layer.cornerRadius = 22
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cornerView.addShadow(color: .black, opacity: 1, offSet: .zero, radius: 30)
        
    }
}

extension NearRestaurantViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.nearRestaurantTableView.dequeueReusableCell(withIdentifier: nearRestaurantCell, for: indexPath) as? NearRestaurantTableViewCell
        cell?.setup(restaurant: self.viewModel.getRestaurants(index: indexPath.row))
        cell?.setupCorner(cornerRadius: 5)
        cell?.delegate = self
        return cell ?? UITableViewCell()
        
    }
    
    
}

extension NearRestaurantViewController: NearRestaurantCellDelegate{
    func receiveMenu(restaurant: RestaurantCodable) {
        let vc = RestaurantDetailsViewController()
        vc.restaurant = restaurant
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func receiveDetail(restaurant: RestaurantCodable) {
        let vc = RestaurantMapViewController()
        vc.restaurantCodable = restaurant
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
