//
//  ContentView.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/5/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var drinkListener = DrinkListener()
    @State private var showingBasket = false
    
    var categories:[String:[Drink]]{
        
        .init(
            grouping:drinkListener.drinks,
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
                        self.showingBasket.toggle()
                    },label: {
                        Image("basket")
                    })
                        .sheet(isPresented: $showingBasket){
                            OrderBasketView()
                    }

            )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
