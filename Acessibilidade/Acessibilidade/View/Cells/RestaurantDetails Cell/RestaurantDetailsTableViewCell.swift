//
//  RestaurantDetailsTableViewCell.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class RestaurantDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var testeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpCell(title: String){
        testeLabel.text = title
    }
}
