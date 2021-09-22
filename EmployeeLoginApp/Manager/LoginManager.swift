//
//  LoginManager.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class LoginManager {
    
    static let sharedInstance =  LoginStore()
    
    /// This function will make the post request, and post the login body
    ///
    /// - Parameters:
    ///        - callback: A callback  with the parameters `result`  and `error` which is a ServerError object.
    ///        - body: Dictionary object containing email and password.
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
