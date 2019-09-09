//
//  MyListViewModel.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation

class MyListViewModel{
    
    
    func numberOfRows() ->  Int{
        var restaurants = MyListManager.shared().getOrder()
        var plates:[PlateCodable] = []
        var numberOfPlates: Int?
        
        for inx in 0..<restaurants.count{
            plates = restaurants[inx].plateCodable ?? [PlateCodable()]
            numberOfPlates = plates.count
        }
        return numberOfPlates ?? 0
    }
    
}
