//
//  MyListViewModel.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation

class MyListViewModel{
    
    var plates:[PlateCodable] = []
    var numberOfPlates: Int?
    
    func numberOfRows() ->  Int{
        var restaurants = MyListManager.shared().getOrder()
        
        for inx in 0..<restaurants.count{
            plates = restaurants[inx].plateCodable ?? [PlateCodable()]
            numberOfPlates = plates.count
        }
        return numberOfPlates ?? 0
    }
    
    func getTotalValue() -> String{
        var total = 0
        for plate in plates {
//            total += plate.priceDouble
        }
        return String(total)
    }
    
}
