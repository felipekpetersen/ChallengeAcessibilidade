//
//  NearRestaurantViewController.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupCornerView()
        setupNearRestaurantLabel()
        setupCategoryPhoto()
    }
    
    
    func setupTableView() {
        self.nearRestaurantTableView.delegate = self
        self.nearRestaurantTableView.dataSource = self
        self.nearRestaurantTableView.separatorStyle = .none
        nearRestaurantTableView.register(UINib(nibName: nearRestaurantCell, bundle: nil), forCellReuseIdentifier: nearRestaurantCell)
    }
    
    func setupCornerView(){
        cornerView.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        cornerView.layer.cornerRadius = 22
        cornerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        roundCorners(cornerRadius: 22, view: cornerView)
    }

//    func roundCorners(cornerRadius: Double, view: UIView) {
//        view.layer.cornerRadius = CGFloat(cornerRadius)
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//    }
//
    func setupNearRestaurantLabel(){
        
        
    }
    
    func setupCategoryPhoto(){
        
        
    }
    
    
 
}


extension NearRestaurantViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.nearRestaurantTableView.dequeueReusableCell(withIdentifier: nearRestaurantCell, for: indexPath) as? NearRestaurantTableViewCell
        return cell ?? UITableViewCell()
    }
    
    
}


