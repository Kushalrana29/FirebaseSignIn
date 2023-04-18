//
//  ViewController.swift
//  FirebaseSignIn
//
//  Created by Kushal Rana on 14/04/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "watch7.png")
        img.contentMode = .scaleAspectFit
        img.layer.cornerRadius =  screenHeight/10
        img.clipsToBounds = true
        return img
    }()
    
    let loginDetailsContainerView : UIView = {
        let view = UIView ()
        //view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    
    
//    let loginDetailStackView: UIStackView = {
//        let sv = UIStackView()
//        sv.axis  = NSLayoutConstraint.Axis.vertical
//        sv.alignment = UIStackView.Alignment.center
//        sv.distribution = UIStackView.Distribution.fillEqually
//        sv.spacing = 10
//        sv.backgroundColor = .red
//        sv.translatesAutoresizingMaskIntoConstraints = false;
//        return sv
//    }()
    
    // keep the loginDetailsContainerView details

    let emailLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let emailTextField : UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.backgroundColor = .lightGray
        textField.placeholder = "  enter email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "  enter password"
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton : UIButton = {
        let lgnBtn = UIButton()
        lgnBtn.backgroundColor = .white
        lgnBtn.setTitle("Login", for:.normal)
        lgnBtn.setTitleColor(.systemBlue, for: .normal)
        lgnBtn.translatesAutoresizingMaskIntoConstraints = false
        lgnBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return lgnBtn
    }()
      

    
    let forgotPasswordButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Forgot your password?", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    let leftView : UIView = {
        let view = UIView ()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let orConnectWithLabel : UILabel = {
       let label = UILabel ()
        label.textColor = .lightGray
        label.text = "or connect with"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightView : UIView = {
        let view = UIView ()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have account?"
        return label
    }()
    
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let socialStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.center
        sv.distribution = UIStackView.Distribution.fillEqually
        //sv.backgroundColor = .red
        sv.translatesAutoresizingMaskIntoConstraints = false;
        return sv
    }()
    
    let googleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let facebookBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let seperatorStackView: UIStackView = {
        let cwsv = UIStackView()
        cwsv.axis  = NSLayoutConstraint.Axis.horizontal
        cwsv.alignment = UIStackView.Alignment.center
        cwsv.distribution = UIStackView.Distribution.fillEqually
        //cwsv.backgroundColor = .gray
        cwsv.spacing = 5
        cwsv.translatesAutoresizingMaskIntoConstraints = false;
        return cwsv
    }()
    
  

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        addConstraints()
        
        
        loginButton.addTarget(self, action: #selector(LoginButtonAction), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)

        self.navigationItem.title = "Login"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)

        // check for already login
        if FirebaseAuth.Auth.auth().currentUser != nil {
            self.showAlert(title: "User Already Signed In", message: "Please logout first")
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
            } catch {
                print("Error in singning out ")
            }
        }

    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    // && (validPassword(passwordTextField: password))
    @objc func LoginButtonAction() {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isValidEmail(email) {
                FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
//                    guard error != nil else {
//                        strongSelf.showAlert(title: "Signed In", message: error.localizedDescription)
//                        return
//                    }
                    
                    let signUpVC = SignOutViewController()
                    strongSelf.navigationController?.pushViewController(signUpVC, animated: true)
                    
                    
                })
            } else {
                print("Invalid email")
                showAlert(title: "Alert", message: "Enter valid email and password")
            }
        }
    }
    
    @objc func signUpButtonPressed() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func addSubviews() {
        self.view.addSubview(profileImageView)
        self.view.addSubview(loginDetailsContainerView)
        
        loginDetailsContainerView.addSubview(emailLabel)
        loginDetailsContainerView.addSubview(emailTextField)
        loginDetailsContainerView.addSubview(passwordLabel)
        loginDetailsContainerView.addSubview(passwordTextField)

        //self.view.addSubview(loginDetailStackView)
        
//        self.view.addSubview(emailLabel)
//        self.view.addSubview(emailTextField)
//        self.view.addSubview(passwordLabel)
//        self.view.addSubview(passwordLabel)

        
        
        self.view.addSubview(dontHaveAccountLabel)
        self.view.addSubview(signUpButton)
        self.view.addSubview(socialStackView)
        self.view.addSubview(seperatorStackView)
        self.view.addSubview(loginButton)
        self.view.addSubview(forgotPasswordButton)
       
        
        // 1 stak
        
//        loginDetailStackView.addArrangedSubview(emailLabel)
//        loginDetailStackView.addArrangedSubview(emailTextField)
//        loginDetailStackView.addArrangedSubview(passwordLabel)
//        loginDetailStackView.addArrangedSubview(passwordTextField)
        
        // 2 stack
        
        seperatorStackView.addArrangedSubview(leftView)
        seperatorStackView.addArrangedSubview(orConnectWithLabel)
        seperatorStackView.addArrangedSubview(rightView)
        
        // 3 stack adding buttons on Stack View
        socialStackView.addArrangedSubview(googleBtn)
        socialStackView.addArrangedSubview(facebookBtn)
        
        //
    }
    
    func addConstraints() {
        
        profileImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth/2 - 75).isActive = true
        profileImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: screenHeight*0.11).isActive = true
        
        profileImageView.heightAnchor.constraint(equalToConstant: screenHeight/5).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: screenHeight/5).isActive = true
        
        loginDetailsContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        loginDetailsContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        loginDetailsContainerView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        
        loginDetailsContainerView.heightAnchor.constraint(equalToConstant: screenHeight/4.5).isActive = true
        
        emailLabel.leadingAnchor.constraint(equalTo: loginDetailsContainerView.leadingAnchor, constant: 10).isActive = true
        emailLabel.topAnchor.constraint(equalTo: loginDetailsContainerView.topAnchor,constant: 60).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        emailTextField.leadingAnchor.constraint(equalTo: loginDetailsContainerView.leadingAnchor, constant: 10).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: loginDetailsContainerView.trailingAnchor, constant: -10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: (screenHeight/4.5)/5).isActive = true
        
        
        passwordLabel.leadingAnchor.constraint(equalTo: loginDetailsContainerView.leadingAnchor, constant: 10).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 10).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        passwordTextField.leadingAnchor.constraint(equalTo: loginDetailsContainerView.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: loginDetailsContainerView.trailingAnchor, constant: -10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: (screenHeight/4.5)/5).isActive = true
        
        
        dontHaveAccountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth*0.2).isActive = true
        dontHaveAccountLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        dontHaveAccountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        signUpButton.leadingAnchor.constraint(equalTo: dontHaveAccountLabel.trailingAnchor, constant: 5).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: dontHaveAccountLabel.bottomAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        socialStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        socialStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        socialStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        socialStackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -10).isActive = true
        
        
        googleBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        googleBtn.leadingAnchor.constraint(equalTo: socialStackView.leadingAnchor, constant:0).isActive = true
        googleBtn.trailingAnchor.constraint(equalTo: facebookBtn.leadingAnchor, constant: -10).isActive = true
        
        facebookBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        facebookBtn.trailingAnchor.constraint(equalTo: socialStackView.trailingAnchor, constant: -40).isActive = true
        facebookBtn.leadingAnchor.constraint(equalTo: googleBtn.trailingAnchor, constant: 0).isActive = true
        
        seperatorStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        seperatorStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        seperatorStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        seperatorStackView.topAnchor.constraint(equalTo: socialStackView.topAnchor, constant: -60).isActive = true
        
        leftView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        orConnectWithLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: loginDetailsContainerView.bottomAnchor, constant: 10).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        forgotPasswordButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
     
    
        
        emailLabel.topAnchor.constraint(equalTo: loginDetailsContainerView.topAnchor, constant: 10).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: loginDetailsContainerView.leftAnchor, constant: 10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    func validPassword(passwordTextField : String) -> Bool {
        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: passwordTextField)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(title: String,message: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            print("User clicked")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User clicked")
        }))
        
        self.present(alert, animated: true, completion: {
        })
                   
    }
}
      
