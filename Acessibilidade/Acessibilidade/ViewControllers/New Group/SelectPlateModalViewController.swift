//
//  SelectPlateModalViewController.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 03/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class SelectPlateModalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        setupTap()
        // Do any additional setup after loading the view.
    }

    func setupTap() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(didGesture))
        gesture.direction = .down
        self.view.addGestureRecognizer(gesture)
    }

    @objc func didGesture() {
        self.dismiss(animated: true, completion: nil)
    }
}
