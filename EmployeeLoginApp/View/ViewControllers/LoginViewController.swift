//
//  ViewController.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
        self.navigationController?.navigationBar.isHidden = true
        self.registerViewModelListeners()
        self.applyTheme()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    ///This function applies UI changes if any.
    func applyTheme() {
        self.loginButton.layer.cornerRadius = 5
    }

    @IBAction func logintapped(_ sender: Any) {
        self.loginIfValid()
    }
    
    
    //MARK: Handle Keyboard events
    /// This function handles soft-keyboard hide if tapped anywhere on the screen
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// This function will hide the soft-keyboard when editing is finished
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    ///This function handles the screen when the keyboard appears.
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = view.convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentOffset = CGPoint(x:0, y:keyboardFrame.size.height/2)
    }
    ///This function handles the screen when the keyboard is dismissed.
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset = .zero
    }
    
  
    func registerViewModelListeners() {
        viewModel.isLoginSuccess.bind { [self] success in
            if success {
                //hide activity indicator after fetching is success
                CommonUtils.sharedInstance.hideActivityIndicator()
                self.showUserList()
                
            } else {
                CommonUtils.sharedInstance.hideActivityIndicator()
                CommonUtils.sharedInstance.showAlert(header: ErrorConstants.defaultErrorHeader, message: ErrorConstants.internetError, actionTitle: StringConstants.alertOK)
            }
        }
    }
    
    ///This function pushes the User details screen once login is succesful.
    func showUserList() {
        guard let vc = storyboard?.instantiateViewController(identifier: "UserListViewController") as? UserListViewController else { return }
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    ///This function checks if the username and password are valid and
    ///proceeds to post the login data as json to the backend.
    func loginIfValid() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }
        if (viewModel.isLoginValid(password, email)) {
            if password == StringConstants.pswd && email == StringConstants.email  {
                CommonUtils.sharedInstance.showActivityIndicator(self.view)
                
                var jsonBody = Dictionary<String, String>()
                jsonBody["email"] = email
                jsonBody["password"] = password
                
                //post the json data as body to the backend.
                viewModel.postLoginData(jsonBody)
            } else {
                CommonUtils.sharedInstance.showAlert(header: ErrorConstants.defaultErrorHeader, message: StringConstants.passwordValidation, actionTitle: StringConstants.alertOK)
            }
        } else {
            CommonUtils.sharedInstance.showAlert(header: StringConstants.invalidCred, message: StringConstants.textFieldValidation, actionTitle: StringConstants.alertOK)
        }
    }
}

//MARK: TextField delegates
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textTag = textField.tag+1
        
        let nextResponder = textField.superview?.viewWithTag(textTag)
        
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        }else {
            self.view.endEditing(true)
        }
        
        return true
    }
    
}
