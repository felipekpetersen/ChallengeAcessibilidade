//
//  NearRestaurantTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class NearRestaurantTableViewCell: UITableViewCell {

    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    @IBAction func menuButton(_ sender: Any) {
    }
    
    
    @IBAction func addressButton(_ sender: Any) {
    }
    
}
