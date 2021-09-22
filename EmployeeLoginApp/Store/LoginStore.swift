//
//  LoginStore.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class LoginStore {
    
    static let sharedInstance = LoginStore()
    
    func postLoginData(_ body: Dictionary<String, String>?, callback:@escaping (_ result: String?, _ error:ServerError?) -> Void) {
        NetworkService.sharedInstance.post(withBaseURL: NetworkConstants.loginAPI, body: body) {
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
