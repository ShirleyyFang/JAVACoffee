//
//  OrderBasketView.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/18/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct OrderBasketView: View {
    
    @ObservedObject var basketListener = BasketListener()
    
    var body: some View {
        
        NavigationView{
            
            List {
                Section{
                    ForEach(self.basketListener.orderBasket?.items ?? []){
                        drink in
                        HStack {
                            Text(drink.name)
                            Spacer()
                            Text("$\(drink.price.clean)")
                        }
                    }
                    .onDelete{(indexSet) in self.deleteItems(at: indexSet)
                    }
                }
                Section {
                    NavigationLink(destination:CheckoutView()){
                        Text("Place Order")
                    }
                }.disabled(self.basketListener.orderBasket?.items.isEmpty ?? true)
            }
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
        }
    }
    func deleteItems(at offsets: IndexSet){
        self.basketListener.orderBasket.items.remove(at: offsets.first!)
        self.basketListener.orderBasket.saveBasketToFirestore()
    }
    
}

struct OrderBasketView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBasketView()
    }
}
