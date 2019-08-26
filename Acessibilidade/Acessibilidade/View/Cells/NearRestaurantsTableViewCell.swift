//
//  NearRestaurantsTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class NearRestaurantsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var TestView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String, color: UIColor) {
        self.titleLabel.text = title
        self.TestView.backgroundColor = color
        self.TestView.layer.cornerRadius = 8
    }
    
}
