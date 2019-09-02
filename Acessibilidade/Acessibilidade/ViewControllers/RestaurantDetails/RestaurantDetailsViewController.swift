//
//  RestaurantDetailsViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class RestaurantDetailsViewController: UIViewController {

    @IBOutlet weak var testeLabelRest: UILabel!
    
    @IBOutlet weak var restauranteImgView: UIImageView!
    
    @IBOutlet weak var tableViewPratos: UITableView!
    
    @IBOutlet weak var listaButton: UIButton!
    
    @IBOutlet weak var subtituloLabel: UILabel!
    
    @IBOutlet weak var backStubtituloView: RoundedView!
    
    let viewModel = RestaurantDetailsViewModel()
    let pratosCell = "RestaurantDetailsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    //MARK: - Setar table view
    func setTableView(){
        tableViewPratos.delegate = self 
        tableViewPratos.dataSource = self
        tableViewPratos.register(UINib(nibName: pratosCell, bundle: nil), forCellReuseIdentifier: pratosCell)
        backStubtituloView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
    }
}

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewPratos.dequeueReusableCell(withIdentifier: pratosCell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.present(PlatesViewController(), animated: true, completion: nil)
    }
}
