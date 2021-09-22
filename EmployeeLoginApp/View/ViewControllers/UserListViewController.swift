//
//  UserListViewController.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var viewModel = UserListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        //Register table view cells.
        tableView.register(UINib(nibName: "UserCardTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.registerViewModelListeners()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CommonUtils.sharedInstance.showActivityIndicator(self.view)
        viewModel.getUserList()
        self.navBar()
    }
    
    func navBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let rightBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.rightBarButtonItem  = rightBarButton
    }
    
    func registerViewModelListeners() {
        viewModel.isGetListSuccess.bind { [self] success in
            if success {
                //Hidingh activity indicator after fetching the list
                CommonUtils.sharedInstance.hideActivityIndicator()
                
                //reload table view after fethcing data
                self.tableView.reloadData()
                
            } else {
                CommonUtils.sharedInstance.hideActivityIndicator()
                CommonUtils.sharedInstance.showAlert(header: ErrorConstants.defaultErrorHeader, message: StringConstants.textFieldValidation, actionTitle: StringConstants.alertOK)
            }
        }
    }
    
    @objc func logoutTapped() {
        UserDefaults.standard.setValue(false, forKey: "LoggedIn")
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? UserCardTableViewCell?  else { return UITableViewCell() }
            cell?.firstNameLabel.text = viewModel.userList?[indexPath.row].first_name
            cell?.lastNameLabel.text = viewModel.userList?[indexPath.row].last_name
            cell?.emailLabel.text = viewModel.userList?[indexPath.row].email
            
            if let imageUrlString = viewModel.userList?[indexPath.row].avatar {
                DispatchQueue.global().async {
                    guard let imageUrl = URL(string: imageUrlString) else { return }
                    if let data = try? Data(contentsOf: imageUrl) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell?.imgView?.image = image
                            }
                        }
                    }
                }
            }
//            else {
//                return UITableViewCell()
//            }
       
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "UserDetailsViewController") as? UserDetailsViewController else { return }
        
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
        vc.fname = viewModel.userList?[selectedRow].first_name
        vc.lname = viewModel.userList?[selectedRow].last_name
        vc.email = viewModel.userList?[selectedRow].email
        vc.image = viewModel.userList?[selectedRow].avatar
        
        navigationController?.pushViewController(vc, animated: true)
    }

}
