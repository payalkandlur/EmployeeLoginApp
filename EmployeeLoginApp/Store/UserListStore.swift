//
//  UserListStore.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class UserListStore {
    
    let networkService = NetworkService()
    
    /// This function will make the get request for the user details.
    ///
    /// - Parameters:
    ///        - callback: A callback  with the parameters `result` having the data and `error` which is a ServerError object.
    func getUserList(callback:@escaping (_ result: Page?, _ error:ServerError?) -> Void) {
        networkService.get(withBaseURL: "https://reqres.in/api/users") {
            (result, error) in
            let decoder = JSONDecoder()
            if error == nil {
                if let resultData = result, let decodedData = try? decoder.decode(Page.self, from: resultData) {
                    callback(decodedData, nil)
                } else {
                    callback(nil, CommonUtils.sharedInstance.defaultError())
                }
            } else {
                callback(nil, CommonUtils.sharedInstance.defaultError())
            }
        }
    }
    
}
