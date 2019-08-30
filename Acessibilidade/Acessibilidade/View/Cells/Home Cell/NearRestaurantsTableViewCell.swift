//
//  NearRestaurantsTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class NearRestaurantsTableViewCell: UITableViewCell {

<<<<<<< HEAD
=======
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    
>>>>>>> localizacao do usuario e integracao
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    func setup(title: String, color: UIColor) {
<<<<<<< HEAD
        
//        self.titleLabel.text = title
//        self.TestView.backgroundColor = color
//        self.TestView.layer.cornerRadius = 8
=======
        self.titleLabel.text = title
        self.testView.backgroundColor = color
        self.testView.layer.cornerRadius = 8
>>>>>>> localizacao do usuario e integracao
    }
    
}
