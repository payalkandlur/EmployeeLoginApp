//
//  UserListViewModel.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class UserListViewModel {

    let userManager = UserListViewManager()
    
    var isGetListSuccess: Dynamic<Bool> = Dynamic(false)
    var userList: [User]?
    var errorMessage = ""
    
    //MARK: Get the user details
    /// This function will get the user data from.
    func getUserList() {
        userManager.getUserList { [weak self]
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
