//
//  DrinkDetail.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/6/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct DrinkDetail: View {
    
    @State private var showingAlert = false
    //for .alert(isPresented: <#T##Binding<Bool>#>, content: <#T##() -> Alert#>)
    
    @State private var showingLogin = false
    
    var drink: Drink
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack(alignment: .bottom) {
                
                Image(drink.imageName)
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                
                Rectangle()
                    .frame(height:80)
                    .foregroundColor(.black)
                    .opacity(0.35)
                    .blur(radius: 10)
                
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        Text(drink.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                    }
                    .padding(.leading)
                    .padding(.bottom)
                    Spacer()
                }//End of HStack
            } //End of ZStack
            .listRowInsets(EdgeInsets())
            Text(drink.description)
                .font(.body)
                .lineLimit(5)
                .padding()
            
            HStack{
                Spacer()
                OrderButton(showAlert: $showingAlert, showLogin: $showingLogin, drink: drink)
                Spacer()
            }
            .padding(.top,50)
            
        }//ENd of Scroll View
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
            .alert(isPresented: $showingAlert){
                Alert(title: Text("Added to Basket!"),dismissButton:
                    .default(Text("OK")))
        }
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink:drinkData[0])
    }
}

struct  OrderButton: View {
    
    @ObservedObject var basketListener = BasketListener()
    @Binding var showAlert: Bool
    @Binding var showLogin: Bool
    
    var drink:Drink //it has to know which drink it is ordering
    
    var body: some View {
        Button(action: {
            
            if FUser.currentUser() != nil && FUser.currentUser()!.onBoarding{
                self.showAlert.toggle()
                self.addItemToBasket()
            }else {
                self.showLogin.toggle()
            }
            

            print("add to basket,\(self.drink.name)")
        }){
            Text("Add to basket")
        }
        .frame(width:200,height:50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
        .sheet(isPresented: self.$showLogin){
            if FUser.currentUser() != nil {
                FinishRegistrationView()
            }else{
                LoginView()
            }
        }
    }
    
    private func addItemToBasket(){
        
        var orderBasket: OrderBasket!
        
        if self.basketListener.orderBasket != nil{
            orderBasket = self.basketListener.orderBasket
        }else{
            orderBasket = OrderBasket()
            orderBasket.ownerId = FUser.currentId()
            orderBasket.id = UUID().uuidString
        }
        
        //check if user has basket
        orderBasket.add(self.drink)
        orderBasket.saveBasketToFirestore()
    }
}
