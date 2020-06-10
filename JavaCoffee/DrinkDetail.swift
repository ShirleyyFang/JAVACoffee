//
//  DrinkDetail.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/6/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct DrinkDetail: View {
    
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
                
                OrderButton(drink:self.drink)
                
                Spacer()
            }
            .padding(.top,50)
            
        }//ENd of Scroll View
        .edgesIgnoringSafeArea(.top)
        .navigationBarHidden(true)
    }
}

struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink:drinkData[0])
    }
}

struct  OrderButton: View {
    
    var drink:Drink //it has to know which drink it is ordering
    
    var body: some View {
        Button(action: {
            print("add to basket,\(self.drink.name)")
        }){
            Text("Add to basket")
        }
        .frame(width:200,height:50)
        .foregroundColor(.white)
        .font(.headline)
        .background(Color.blue)
        .cornerRadius(10)
    }
}
