//
//  FUser.swift
//  JavaCoffee
//
//  Created by Yanbing Fang on 6/22/20.
//  Copyright © 2020 Yanbing. All rights reserved.
//

import Foundation
import FirebaseAuth

class FUser{
    
    let id: String //all of below are changable by users except id
    var email: String
    var firstName: String
    var lastName: String
    var fullName:String
    var phoneNumber: String
    
    var fullAddress: String?
    var onBoarding: Bool
    
    init(_id:String, _email:String, _firstName:String, _lastName: String, _phoneNumber: String){
        
        id = _id
        email = _email
        firstName = _firstName
        lastName = _lastName
        fullName = firstName + " " + lastName
        phoneNumber = _phoneNumber
        onBoarding = false
    }
    
    class func currentId() ->String { //call this function without initiating the FUser
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser? { //when there is no local user
        if Auth.auth().currentUser != nil{
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER){ //Local Data persistance - User default
                return nil
            }
        }
        return nil
    }
    
    class func loginUserWith(email:String,password:String,completion:@escaping(_ error:
        Error?,_ isEmailVerfied:Bool) -> Void){
        
        Auth.auth().signIn(withEmail:email,password: password){(AuthDataResult,error) in
            
            if error == nil{
                if AuthDataResult!.user.isEmailVerified {
                    
                    //download fuser object and save it locally
                    
                }else{
                    completion(error,false)
                }
            }else {
                completion(error,false)
            }
            
        }
    }
}
