//
//  FirebaseReference.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/5/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum FCollectionReference: String{
    case User
    case Menu
    case Order
    case Basket
}

func FirebaseReference(_ collectionReference: FCollectionReference) ->
    CollectionReference {
        return Firestore.firestore().collection(collectionReference.rawValue)
}
