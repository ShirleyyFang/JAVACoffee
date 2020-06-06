//
//  ContentView.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/5/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var categories:[String:[Drink]]{
        .init(
            grouping:drinkData,
            by:{$0.category.rawValue}
        )
    }
    
    var body: some View {
        
        NavigationView {
            
            List(categories.keys.sorted(),id: \String.self){
                key in
                
                DrinkRow(categoryName: "\(key) Drink".uppercased(), drinks: self.categories[key]!)
                    .frame(height:320)
                    .padding(.top)
                    .padding(.bottom)
            }
            
                .navigationBarTitle(Text("JAVA Coffee"))
                .navigationBarItems(
                    leading: Button(action: {
                        //code
                        print("log out")
                        //createMenu() //only enable once since we don't want duplicate menu
                    },label: {
                        Text("Log Out")
                    }),
                    trailing: Button(action: {
                        //code
                        print("basket")
                    },label: {
                        Image("basket")
                    })

            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
