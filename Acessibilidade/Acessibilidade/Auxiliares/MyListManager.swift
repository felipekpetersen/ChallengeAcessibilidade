//
//  Singleton.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 05/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

struct MyListDecodable: Decodable {
    var restaurantName: String?
    var plateCodable: [PlateCodable]?
}

public class MyListManager {
    
    private init() {
    }

    private static let _shared = MyListManager()
    private var _myLists: [MyListDecodable] = []
    
    class func shared() -> MyListManager {
        return sharedManager
    }
    
    private static var sharedManager: MyListManager = {
        let manager = MyListManager()
        return manager
    }()

    var myList: [MyListDecodable]? {
        get {
            var copy: [MyListDecodable] = []
            copy.append(contentsOf: _myLists)
            return copy
        }
    }
    func addOrder(restaurantName: String, plate: PlateCodable) {
//        var newList = MyListDecodable()
//        newList.restaurantName = nil
//        if !(_myLists.contains { (rest) -> Bool in
//             return rest.restaurantName == restaurant
//        }) {
//            newList.restaurantName = restaurant
//
//        }
//
//        newList.plateCodable = [PlateCodable]()
//        newList.plateCodable?.append(plate)
//
//         _myLists.append(newList)
        var didCreate = false
        for index in _myLists.indices {
            if restaurantName == _myLists[index].restaurantName {
                _myLists[index].plateCodable?.append(plate)
                didCreate = true
            }
        }
        
        if !didCreate {
            var newList = MyListDecodable()
            newList.restaurantName = restaurantName
            newList.plateCodable = [PlateCodable]()
            newList.plateCodable?.append(plate)
            _myLists.append(newList)
        }
    }
    
    func getOrder() -> [MyListDecodable] {
        return _myLists
    }
}
