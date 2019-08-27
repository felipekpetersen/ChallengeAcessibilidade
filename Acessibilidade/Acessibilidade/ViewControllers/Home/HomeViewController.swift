//
//  HomeViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoriasTeste: UILabel!
    @IBOutlet weak var restaurantesProximosTeste: UILabel!
    //    private let itemsPerRow
    
    let viewModel = HomeViewModel()
    let restaurantCell = "NearRestaurantsTableViewCell"
    let categoriesCell = "CategoriesRestaurantsCollectionViewCell"
    private var sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    private let itemsPerRow: CGFloat = 4

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCollectionView()
        setupLabels()
        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: restaurantCell, bundle: nil), forCellReuseIdentifier: restaurantCell)
        self.tableView.separatorStyle = .none
    }
    
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.isAccessibilityElement = true
        collectionView.register(UINib(nibName: categoriesCell, bundle: nil), forCellWithReuseIdentifier: categoriesCell)
    }
    
    func setupLabels(){
        self.categoriasTeste.text = "5 Categorias perto de você"
        self.restaurantesProximosTeste.text = "15 restaurantes próximos a você"
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: restaurantCell, for: indexPath) as! NearRestaurantsTableViewCell
        cell.setup(title: "nome do restaurante", color: .gray)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(RestaurantListViewController(), animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: categoriesCell, for: indexPath) as! CategoriesRestaurantsCollectionViewCell
        cell.setup(color: .blue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/4 - sectionInsets.left, height: self.view.frame.width/4 - sectionInsets.left)
//       return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}




