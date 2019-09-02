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
    @IBOutlet weak var smallTitleLabel: UILabel!
    
    let viewModel = RestaurantDetailsViewModel()
    let pratosCell = "RestaurantDetailsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setViews()
        setLabels()
//        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
    }
    
    //MARK: - Setar table view
    func setTableView(){
        tableViewPratos.delegate = self 
        tableViewPratos.dataSource = self
        tableViewPratos.register(UINib(nibName: pratosCell, bundle: nil), forCellReuseIdentifier: pratosCell)
    }
    
    func setViews(){
        backStubtituloView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        backStubtituloView.addShadow(color: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), opacity: 1, offSet: CGSize(width: 10, height: 10), radius: 13, scale: true)
        restauranteImgView.image = UIImage(named: "pizzaPlaceholder")
    }
    
    func setLabels(){
        testeLabelRest.textColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        testeLabelRest.font = UIFont.boldSystemFont(ofSize: 28.0)
        smallTitleLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.9607843137, blue: 0.9725490196, alpha: 1)
        smallTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
    }
    
//    func setNavigationBar(){
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
//    }
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
