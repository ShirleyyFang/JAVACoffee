//
//  Order.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/18/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import Foundation

class Order:Identifiable {
    
    var id:String!
    var customerId: String!
    var orderItems:[Drink] = []
    var amount: Double!
    
    func saveOrderToFirestore(){
        FirebaseReference(.Order).document(self.id).setData(orderDictionaryFrom(self)){
            error in
            if error != nil{
                print("error saving order to firestore:",error!.localizedDescription)
            }
        }
    }
}

func orderDictionaryFrom(_ order:Order) -> [String:Any]{
    var allDrinkIds:[String] = []
    
    for drink in order.orderItems{
        allDrinkIds.append(drink.id)
    }
    return NSDictionary(objects:[order.id,
                                 order.customerId,
                                 allDrinkIds,
                                 order.amount],
                        forKeys:[kID as NSCopying,
                                 kCUSTOMERID as NSCopying,
                                 kDRINKIDs as NSCopying,
                                 kAMOUNT as NSCopying
    ]) as! [String:Any]
}
