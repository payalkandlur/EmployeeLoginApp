//
//  CommonUtils.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import Foundation
import UIKit

class CommonUtils {
    
    static let sharedInstance = CommonUtils()
    var window = UIApplication.shared.windows.first { $0.isKeyWindow }
    
    var activityView: UIActivityIndicatorView?
    
    //MARK: Activity Indicator
    ///This function displays the activity indicator on the view.
    func showActivityIndicator(_ view: UIView) {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = view.center
        view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    ///This function hides the activity indicator on the view.
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }

    //MARK: Alert View
    ///This function displays the alert on the screen.
    func showAlert(header: String, message: String, actionTitle: String) {
        var topViewController = self.window?.rootViewController
        while topViewController?.presentedViewController != nil
        {
            topViewController = topViewController?.presentedViewController
        }
        
        let alertController = UIAlertController(title: header, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        
        topViewController?.present(alertController, animated: true, completion: nil)
        
    }

    //MARK: Error Handling
    ///This handles errors if any.
    func defaultError() -> ServerError {
        let error = NSError(domain: "com.example.Users", code: 0, userInfo: nil)
        let customError = ServerError(err: error)
        return customError
    }
    
}
