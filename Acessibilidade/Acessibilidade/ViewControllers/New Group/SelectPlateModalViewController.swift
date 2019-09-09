//
//  SelectPlateModalViewController.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 03/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

enum ModalState {
    case selectPlate
    case changeView
}

protocol SelectPlateModalViewControllerDelegate {
    func didTapOpenPlates()
    func didTapOtherMenu()
}

class SelectPlateModalViewController: UIViewController {

    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var modalView: RoundedView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var selectPlateView: RoundedView!
    @IBOutlet weak var cancelView: RoundedView!
    @IBOutlet weak var changeMenuView: RoundedView!
    @IBOutlet weak var selectPlateLabel: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    
    var viewState: ModalState = .selectPlate
    var plate: PlateCodable?
    var restaurantName: String?
    var delegate: SelectPlateModalViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        setupTap()
        setupShadow()
        setupLabels()
        self.setupView(forState: viewState)
    }
    
    func setupShadow() {
        modalView.addShadow(color: .black, opacity: 0.45, offSet: CGSize(width: 0, height: -10), radius: 30)
        selectPlateView.addShadow(color:UIColor(rgb: 0x7E7E7E), opacity: 0.25, offSet: .zero, radius: 16)
        cancelView.addShadow(color:UIColor(rgb: 0x7E7E7E), opacity: 0.25, offSet: .zero, radius: 16)
    }

    func setupTap() {
        let outsideTap = UITapGestureRecognizer(target: self, action: #selector(didTapOutside))
        self.outsideView.addGestureRecognizer(outsideTap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissTapped))
        swipe.direction = .down
        self.view.addGestureRecognizer(swipe)
        
        let otherMenuTap = UITapGestureRecognizer(target: self, action: #selector(didTapOtherMenu))
        self.changeMenuView.addGestureRecognizer(otherMenuTap)
        
        let selectPlateTap = UITapGestureRecognizer(target: self, action: #selector(didSelectPlate))
        self.selectPlateView.addGestureRecognizer(selectPlateTap)
        
        let cancelTap = UITapGestureRecognizer(target: self, action: #selector(didTapCancel))
        self.cancelView.addGestureRecognizer(cancelTap)
    }
    
    func setupLabels() {
        nameLabel.text = plate?.name
        priceLabel.text = plate?.price
        descLabel.text = plate?.description
        
    }
    
    func setupView(forState: ModalState) {
        UIView.animate(withDuration: 1) {
            switch forState {
            case .selectPlate:
                self.menuHeightConstraint.constant = 0
            case .changeView:
                
                self.priceLabel.isHidden = true
                self.cancelLabel.text = "Ir para pratos selecionados"
                self.selectPlateLabel.text = "Continuar de onde estava"
                self.nameLabel.text = "Prato adicionado com sucesso"
                self.descLabel.text = "Selecione a opção que você deseja para continuar:"
                self.changeMenuView.alpha = 1
                self.menuHeightConstraint.constant = 60
            }
        }
        
        UIView.transition(with: self.modalView, duration: 0.5, options: .transitionCrossDissolve, animations: {
        }, completion: nil)
    }

    @objc func didTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapOtherMenu() {
        self.delegate?.didTapOtherMenu()
    }
    
    @objc func didSelectPlate() {
        switch viewState {
        case .selectPlate:
            guard let restaurantName = restaurantName else {return}
            guard let plate = plate else {return}
            MyListManager.shared().addOrder(restaurantName: restaurantName, plate: plate)
            self.viewState = .changeView
            setupView(forState: self.viewState)
        case .changeView:
            self.dismiss(animated: true, completion: nil)
        }
        //TODO:- selecionar prato
    }
    
    @objc func didTapCancel() {
        switch viewState {
        case .selectPlate:
            self.dismiss(animated: true, completion: nil)
        case .changeView:
            self.delegate?.didTapOpenPlates()
        }
    }
}
