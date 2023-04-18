//
//  SignOutViewController.swift
//  FirebaseSignIn
//
//  Created by Kushal Rana on 18/04/23.
//

import UIKit
import FirebaseAuth

class SignOutViewController: UIViewController {
    
    let logOutButton : UIButton = {
        let lgnBtn = UIButton()
        lgnBtn.backgroundColor = .white
        lgnBtn.setTitle("LogOut", for:.normal)
        lgnBtn.setTitleColor(.systemBlue, for: .normal)
        lgnBtn.translatesAutoresizingMaskIntoConstraints = false
        lgnBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return lgnBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.view.addSubview(logOutButton)
        
        logOutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        
        logOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60).isActive = true
        logOutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    @objc func logoutPressed() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Error in singning out ")
        }
    }
    

   
}
