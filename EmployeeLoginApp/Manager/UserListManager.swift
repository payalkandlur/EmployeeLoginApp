//
//  UserListViewManager.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation


class UserListViewManager {
    
    static let sharedInstance =  UserListViewManager()
    
    func getUserList(callback:@escaping (_ result:Page?, _ error:ServerError?) -> Void) {
        UserListStore.sharedInstance.getUserList() {
            (result, error) in
            if error == nil {
                callback(result,nil)
            } else {
                callback(nil, error)
            }
        }
    }
}
