//
//  UserListStore.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation

class UserListStore {
    
    static let sharedInstance = UserListStore()
    
    func getUserList(callback:@escaping (_ result: Page?, _ error:ServerError?) -> Void) {
        NetworkService.sharedInstance.get(withBaseURL: NetworkConstants.userAPI) {
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
