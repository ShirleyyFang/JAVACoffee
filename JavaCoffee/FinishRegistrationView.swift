//
//  FinishRegistrationView.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/22/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct FinishRegistrationView: View {
    
    @State var name = ""
    @State var surname = ""
    @State var telephone = ""
    @State var address = ""
    
    var body: some View {
        Form{
            Section(){
                Text("Finish Registration")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding([.top,.bottom],20)
                TextField("Name",text:$name)
                TextField("Surename",text:$surname)
                TextField("Telephone",text:$telephone)
                TextField("Address",text:$address)
            }
            
            Section(){
                Button(action:{
                    self.finishRegistration()
                },label:{
                    Text("Finished Registration")
                })
            }.disabled(!self.fieldsCompleted())
            
        }//End of Form
    }
    private func finishRegistration(){

    }
    private func fieldsCompleted() -> Bool{
        return self.name != "" && self.surname != "" && self.telephone != "" && self.address != ""
    }
}

struct FinishRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        FinishRegistrationView()
    }
}