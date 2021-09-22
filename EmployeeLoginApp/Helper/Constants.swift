//
//  Constants.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

struct StringConstants {
    
    static let alertOK = "OK"
    static let passwordValidation = "Password or Email entered is wrong, please check"
    static let textFieldValidation = "Please enter correct email and password"
    static let password = "password123"
    static let email = "eve.holt@reqres.in"
    static let invalidCred = "Invalid Username and Password"
}

struct NetworkConstants {
    static let loginAPI = "https://reqres.in/api/login"
    static let userAPI = "https://reqres.in/api/users"
}

struct ErrorConstants {
    static let defaultError = "Something went wrong, try again later."
    static let internetError = "No Internet! Please check your connection."
    static let loginFailedHeader = "Login Failed"
    static let defaultErrorHeader = "Error"
}
