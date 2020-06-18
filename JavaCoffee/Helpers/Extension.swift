//
//  Extension.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/18/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import Foundation

extension Double {
    var clean:String{
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format:"%.0f",
        self):String(self)
    }
}
