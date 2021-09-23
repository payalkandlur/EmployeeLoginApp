//
//  UserDetailsViewController.swift
//  EmployeeLoginApp
//
//  Created by Payal Kandlur on 22/09/21.
//

import UIKit

class UserDetailsViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var fname : String?
    var lname: String?
    var email : String?
    var image : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.addContent()
//        self.navigationController?.navigationBar.isHidden = false
        self.firstName.text = self.fname
        self.lastName.text = self.lname
        self.emailLabel.text = self.email
        
        if let imageUrlString = self.image {
            DispatchQueue.global().async {
                guard let imageUrl = URL(string: imageUrlString) else { return }
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imgView.image = image
                        }
                    }
                }
            }
        }
    }
    
    func addContent() {
        self.imgView.layer.cornerRadius = 20
    }
    
    ///NavBar items handled
    func navBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        let leftBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem  = leftBarButton
    }
    
    @objc func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
