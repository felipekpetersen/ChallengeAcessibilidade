//
//  MenuTableViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(category: CategoryCodable){
        categoryNameLabel.text = category.name
    }
    
    func setupCornerView(cornerRadius: CGFloat){
        cornerView.layer.cornerRadius = cornerRadius
        cornerView.addShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0, height: 4), radius: 4)
    }

}
