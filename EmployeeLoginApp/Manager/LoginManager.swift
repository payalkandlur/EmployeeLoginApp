//
//  LoginManager.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class LoginManager {
    
    static let sharedInstance =  LoginStore()
    
    func postLoginData(_ body: Dictionary<String, String>?, callback:@escaping (_ result:String?, _ error:ServerError?) -> Void) {
        LoginStore.sharedInstance.postLoginData(body) {
            (result, error) in
            if error == nil {
                callback(result,nil)
            } else {
                callback(nil, error)
            }
        }
    }
}
