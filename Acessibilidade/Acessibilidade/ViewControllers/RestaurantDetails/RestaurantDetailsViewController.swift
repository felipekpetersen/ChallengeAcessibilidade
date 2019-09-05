//
//  RestaurantDetailsViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import UIKit

class RestaurantDetailsViewController: UIViewController{

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restauranteImgView: UIImageView!
    @IBOutlet weak var cardapiosTableView: UITableView!
    @IBOutlet weak var listaButton: UIButton!
    @IBOutlet weak var numberOfMenusLabel: UILabel!
    @IBOutlet weak var backStubtituloView: RoundedView!
    @IBOutlet weak var smallTitleLabel: UILabel!
    

    let viewModel = RestaurantDetailsViewModel()
    let cardapiosCell = "RestaurantDetailsTableViewCell"
    var restaurant = RestaurantCodable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViews()
        setLabels()
        viewModel.restaurant = self.restaurant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    //MARK: - Setar table view
    func setTableView(){
        cardapiosTableView.delegate = self 
        cardapiosTableView.dataSource = self
        cardapiosTableView.register(UINib(nibName: cardapiosCell, bundle: nil), forCellReuseIdentifier: cardapiosCell)
        cardapiosTableView.separatorStyle = .none
        
    }
    
    func setViews(){
        self.view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        backStubtituloView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        backStubtituloView.addShadowWithBezier(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), opacity: 1, offSet: .zero, radius: 100)
        restauranteImgView.image = UIImage(named: "pizzaPlaceholder")
    }
    
    func setLabels(){
        restaurantNameLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        restaurantNameLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        restaurantNameLabel.text = restaurant.name
        smallTitleLabel.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        smallTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        guard let restaurantsCount = restaurant.menus?.count else {return}
        numberOfMenusLabel.text = "Há \(restaurantsCount) tipos de cárdapios"
        numberOfMenusLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.cardapiosTableView.dequeueReusableCell(withIdentifier: cardapiosCell, for: indexPath) as? RestaurantDetailsTableViewCell
        var menu = self.viewModel.getMenu(row: indexPath.row)
        cell?.setUpCell(menu: menu)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MenuViewController()
        vc.menu = self.viewModel.getMenu(row: indexPath.row)
        vc.restaurant = self.viewModel.getRestaurant(restaurant: restaurant)
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.present(MenuViewController(), animated: true, completion: nil)
    }
}
