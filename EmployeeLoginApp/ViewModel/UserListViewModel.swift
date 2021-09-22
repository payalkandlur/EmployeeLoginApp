//
//  UserListViewModel.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class UserListViewModel {

    
    var isGetListSuccess: Dynamic<Bool> = Dynamic(false)
    var userList: [User]?
    var errorMessage = ""
    

    func getUserList() {
        UserListViewManager.sharedInstance.getUserList { [weak self]
            (result, error)  in
            if error == nil {
                if let data = result?.data {
                    self?.userList = data
                }
                self?.isGetListSuccess.value = true
            } else {
                self?.errorMessage = error?.errorMessage ?? ErrorConstants.defaultError
                self?.isGetListSuccess.value = false
            }
        }
    }
}
