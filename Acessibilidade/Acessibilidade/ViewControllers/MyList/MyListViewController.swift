//
//  MyListViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController {
    
    @IBOutlet weak var testeLabel: UILabel!
    @IBOutlet weak var testeTableView: UITableView!
    
    let viewModel = MyListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    func setTableView(){
        self.testeTableView.delegate = self
        self.testeTableView.dataSource = self
    }

}

extension MyListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
    }
}
