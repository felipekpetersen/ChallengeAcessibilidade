//
//  RestaurantCellTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class RestaurantCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var testeView: UIView!
    @IBOutlet weak var testeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }
    
    func setup(color: UIColor, text: String) {
        testeView.backgroundColor = color
        testeLabel.text = text
    }
}
