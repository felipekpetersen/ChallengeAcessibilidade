//
//  PlatesViewController.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class PlatesViewController: UIViewController {

    @IBOutlet weak var plateNameLabel: UILabel!
    @IBOutlet weak var plateDetailsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPlateButton(_ sender: Any) {
        // adicionar o prato na lista
        dismiss(animated: true, completion: nil)
    }
}
