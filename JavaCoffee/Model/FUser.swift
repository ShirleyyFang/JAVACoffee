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
    
    init(_ dictionary:NSDictionary){
        
        id = dictionary[kID] as? String ?? ""
        email = dictionary[kEMAIL] as? String ?? ""
        firstName = dictionary[kFIRSTNAME] as? String ?? ""
        lastName = dictionary[kLASTNAME] as? String ?? ""
        
        fullName = firstName + " " + lastName
        fullAddress = dictionary[kFULLADDRESS] as? String ?? ""
        phoneNumber = dictionary[kPHONENUMBER] as? String ?? ""
        onBoarding = dictionary[kONBOARD] as? Bool ?? false
    }
    
    class func currentId() ->String { //call this function without initiating the FUser
        return Auth.auth().currentUser!.uid
    }
    
    class func currentUser() -> FUser? { //when there is no local user
        if Auth.auth().currentUser != nil{
            if let dictionary = userDefaults.object(forKey: kCURRENTUSER){ //Local Data persistance - User default
                return FUser.init(dictionary as! NSDictionary)
            }
        }
        return nil
    }
    
    class func loginUserWith(email:String,password:String,completion:@escaping(_ error:
        Error?,_ isEmailVerfied:Bool) -> Void){
        
        Auth.auth().signIn(withEmail:email,password: password){(AuthDataResult,error) in
            
            if error == nil{
                if AuthDataResult!.user.isEmailVerified {
                    
                    downloadUserFromFirestore(userId:AuthDataResult!.user.uid,email:email){(error) in
                        completion(error,true)
                    }//email verfication done, download user information to locally
                    
                }else{
                    completion(error,false) //email verification isn't done
                }
            }else {
                completion(error,false)   //email or password is not correct
            }
        }
    }
    
    class func registerUserWith(email:String,password:String,completion:@escaping (_ error:Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) {(AuthDataResult,error) in
            completion(error)
            if error == nil {
                AuthDataResult!.user.sendEmailVerification{(error) in
                    print("verfication email sent error is:",error?.localizedDescription)
                }
            }
        }
    }
    
    class func  resetPassword(email:String,completion:@escaping(_ error:Error?) ->Void){
        
        Auth.auth().sendPasswordReset(withEmail: email) {(error) in
            completion(error)
        }
    }
    
    class func logOutCurrentUser(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            userDefaults.removeObject(forKey: kCURRENTUSER)
            userDefaults.synchronize()
            
            completion(nil)
        }catch let error as Error{
            completion(error)
        }
    }
}
    
func downloadUserFromFirestore(userId:String,email:String,completion:@escaping(_ error:Error?) -> Void){
        FirebaseReference(.User).document(userId).getDocument{(snapshot,error) in
            guard let snapshot = snapshot else {return}
            if snapshot.exists {
                saveUserLocally(userDictionary: snapshot.data()! as NSDictionary)
            }else{
                let user = FUser(_id: userId, _email: email, _firstName: "", _lastName: "", _phoneNumber: "")
                saveUserLocally(userDictionary: userDictionaryFrom(user: user) as NSDictionary)
                saveUserToFirestore(fUser: user)
            }
            completion(error)
        }
    }

func saveUserToFirestore(fUser: FUser){
    FirebaseReference(.User).document(fUser.id).setData(userDictionaryFrom(user: fUser)){(error) in
        if error != nil{
            print("Error creating fuser object:",error!.localizedDescription)
        }
    }
}

func saveUserLocally(userDictionary:NSDictionary){
    userDefaults.set(userDictionary, forKey: kCURRENTUSER)
    userDefaults.synchronize()
}


func userDictionaryFrom(user:FUser) -> [String:Any]{
    return NSDictionary(objects:[user.id,
                                user.email,
                                user.firstName,
                                user.lastName,
                                user.fullName,
                                user.fullAddress ?? "",
                                user.onBoarding,
                                user.phoneNumber
                                ],
                        forKeys: [kID as NSCopying,
                                 kEMAIL as NSCopying,
                                 kFIRSTNAME as NSCopying,
                                 kLASTNAME as NSCopying,
                                 kFULLNAME as NSCopying,
                                 kFULLADDRESS as NSCopying,
                                 kONBOARD as NSCopying,
                                 kPHONENUMBER as NSCopying]
                           ) as! [String:Any]
}

func updateCurrentUser(withValue:[String:Any],completion:@escaping (_ error: Error?) -> Void){
    
    if let dictionary = userDefaults.object(forKey: kCURRENTUSER){
        
        let userObject = (dictionary as! NSDictionary).mutableCopy() as! NSMutableDictionary
        
        userObject.setValuesForKeys(withValue)
        
        FirebaseReference(.User).document(FUser.currentId()).updateData(withValue){(error) in
            
            completion(error)
            if error == nil{
                saveUserLocally(userDictionary: userObject)
            }
            
        }
    }
    
}
