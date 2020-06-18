//
//  OrderBasket.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/17/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import Foundation
import Firebase

class OrderBasket: Identifiable {
    
    var id: String!
    var ownerId: String!
    var items:[Drink] = []
    
    var total:Double {
        if items.count > 0 {
            return items.reduce(0){$0 + $1.price}
        }else{
            return 0.0
        }
    }
    
    func add(_ item:Drink){
        items.append(item)
    }
    
    func remove(_ item:Drink){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
    }
    
    func emptyBasket(){
        self.items = []
        //save to firebase
    }
    
    func saveBasketToFirestore(){
        FirebaseReference(.Basket).document(self.id).setData(basketDictionaryFrom(self))
    }
}

//func basketDictionaryFrom(_ basket:OrderBasket) -> [String:Any]{
//    
//}