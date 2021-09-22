//
//  File.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class LoginViewModel: NSObject {
    
    static let sharedInstance = LoginViewModel()
    var isLoginSuccess: Dynamic<Bool> = Dynamic(false)
    var errorMessage = ""
    
    var token = ""
    
    //MARK: POst the login details
    /// This function will post the login data from.
    ///
    /// - Parameters:
    ///        - body: Dictionary object containing email and password.
    func postLoginData(_ loginBody: Dictionary<String, String>?) {
        LoginManager.sharedInstance.postLoginData(loginBody) { [weak self]
            (result, error)  in
            if error == nil {
                if let token = result {
                    self?.token = token
                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                    self?.isLoginSuccess.value = true
                }
            } else {
                self?.errorMessage = error?.errorMessage ?? ErrorConstants.defaultError
                self?.isLoginSuccess.value = false
            }
        }
    }
    
    ///Chceks if username and password is entered
    func isLoginValid(_ password: String, _ email: String) -> Bool {
        if !email.isEmpty || !password.isEmpty {
            return true
        } else {
            return false
        }
    }
}
