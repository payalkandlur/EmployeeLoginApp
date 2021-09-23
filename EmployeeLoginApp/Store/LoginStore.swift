//
//  LoginStore.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class LoginStore {
    
    let networkService = NetworkService()
    
    /// This function will make the post request, and post the login body
    ///
    /// - Parameters:
    ///        - callback: A callback  with the parameters `result` having the token and `error` which is a ServerError object.
    ///        - body: Dictionary object containing email and password.
    func postLoginData(_ body: Dictionary<String, String>?, callback:@escaping (_ result: String?, _ error:ServerError?) -> Void) {
        networkService.post(withBaseURL: "https://reqres.in/api/login", body: body) {
            (result, error) in
            if error == nil {
                if let resultDict = result as? [String: Any] {
                    if let token = resultDict["token"] as? String {
                        callback(token, nil)
                    } else if let error = resultDict["error"] as? String {
                        print(error)
                        callback(nil, CommonUtils.sharedInstance.defaultError())
                    }
                } else {
                    callback(nil, CommonUtils.sharedInstance.defaultError())
                }
            } else {
                callback(nil, error)
            }
        }
    }
    
}
