//
//  ServerError.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

struct ServerError {
    
    var error:NSError?
    var errorCode: Int
    var errorMessage: String?

    init(err:NSError, customErrorMessage: String? = nil) {
        self.error = err
        self.errorCode = err.code
        self.errorMessage = err.localizedDescription
        if let customError = customErrorMessage {
            self.errorMessage = customError
        } else {
            self.setUserMessage()
        }
    }
    
    /// This function will set the custom error message
    mutating func setUserMessage() {
        
        switch self.errorCode {
        case 0:
            self.errorMessage = ErrorConstants.defaultError
        case -1009:
            self.errorMessage = ErrorConstants.internetError
        case 400:
            self.errorMessage = ErrorConstants.defaultError
        default:
            self.errorMessage = ErrorConstants.defaultError
        }
    }
    
}
