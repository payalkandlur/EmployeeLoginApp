//
//  UserListViewManager.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation


class UserListViewManager {
    
    let userListStore =  UserListStore()
    
    /// This function will make the get request for the user details.
    ///
    /// - Parameters:
    ///        - callback: A callback  with the parameters `result` having the data and `error` which is a ServerError object.
    func getUserList(callback:@escaping (_ result:Page?, _ error:ServerError?) -> Void) {
        userListStore.getUserList() {
            (result, error) in
            if error == nil {
                callback(result,nil)
            } else {
                callback(nil, error)
            }
        }
    }
}
