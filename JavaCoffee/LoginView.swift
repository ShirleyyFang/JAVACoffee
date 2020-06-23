//
//  LoginView.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/22/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var showingSignup = false
    
    @State var email = ""
    @State var password = ""
    @State var repeatPassword = ""
    
    
    var body: some View {
        
        VStack{
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.bottom,.top],20)
            
            VStack(alignment: .leading){
                VStack(alignment:.leading){
                    Text("Email")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    TextField("Enter your email",text:$email)
                    Divider()
                    
                    Text("Password")
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(Color.init(.label))
                        .opacity(0.75)
                    
                    SecureField("Enter your password",text:$password)
                    Divider()
                    
                    if showingSignup {
                        Text("Repeat Password")
                            .font(.headline)
                            .fontWeight(.light)
                            .foregroundColor(Color.init(.label))
                            .opacity(0.75)
                        SecureField("Repeat password",text:$repeatPassword)
                        Divider()
                    }
                }
                    .padding(.bottom,15) //end of VStack
                    .animation(.easeOut(duration:0.1))
                
                
                HStack{
                    Spacer()
                    Button (action: {
                        self.resetPassword()
                    }, label:{
                        Text("Forget Password?")
                            .foregroundColor(Color.gray.opacity(0.5))
                    })
                }//End of HStack
            }.padding(.horizontal,6)//End of VStack
            
            Button(action: {
                self.showingSignup ? self.signUpUser():self.loginUser()
            }, label: {
                Text(showingSignup ? "Sign Up" : "Sign in") //same as an if-statement
                    .foregroundColor(.white)
                    .frame(width:UIScreen.main.bounds.width - 120)
                .padding()
            })//End of button
                .background(Color.blue)
                .clipShape(Capsule())
                .padding(.top,45)
            SignUpView(showingSignup: $showingSignup)
        }//End of VStack
    }
    
    private func signUpUser(){}
    
    private func loginUser(){}
    
    private func resetPassword(){}
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct SignUpView: View{
    
    @Binding var showingSignup: Bool
    
    var body: some View{
        VStack{
            Spacer()
            HStack(spacing: 8){
                Text("Don't have an Account?")
                    .foregroundColor(Color.gray.opacity(0.5))
                Button(action:{
                    self.showingSignup.toggle() //switch showingSignup between true and false
                },label: {
                    Text("Sign up")
                })
                    .foregroundColor(.blue)
            }.padding(.top,25) //End of HStack
        }//End of VStack
    }
}
