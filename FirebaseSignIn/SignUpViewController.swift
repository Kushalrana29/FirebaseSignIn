//
//  SignUpViewController.swift
//  FirebaseSignIn
//
//  Created by Kushal Rana on 16/04/23.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
   
    var imagePicker = UIImagePickerController()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
   
    let signUpImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "watch7.png")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = screenHeight/10
        img.isUserInteractionEnabled = true
        img.backgroundColor = .yellow
        img.clipsToBounds = true
        return img
    }()
    
    
    let cameraBtn : UIButton = {
        let btn = UIButton ()
        btn.setImage(UIImage(systemName: "camera"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .lightGray
        return btn
    }()
    
    let signUpContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userNameLabel : UILabel = {
        let label = UILabel ()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNameTextField : UITextField = {
        let textField = UITextField ()
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.backgroundColor = .lightGray
        textField.setLeftPaddingPoints(5)
        textField.placeholder = "Enter Username Here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailLabel : UILabel = {
        let emailLabel = UILabel ()
        emailLabel.text = "email"
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.textColor = .black
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        return emailLabel
    }()
     
    let emailTextField : UITextField = {
        let tf = UITextField ()
        tf.placeholder = "Enter your email"
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.setLeftPaddingPoints(5)
        tf.backgroundColor = .lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordLabel : UILabel = {
        let label = UILabel ()
        label .text = "password"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextField : UITextField = {
        let tf = UITextField ()
        tf.placeholder = "Enter Password "
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.setLeftPaddingPoints(5)
        tf.backgroundColor = .lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
     
    let confirmPasswordLabel : UILabel = {
        let label = UILabel ()
        label.text = "confirm password"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let confirmPasswordTextField : UITextField = {
        let tf = UITextField ()
        tf.placeholder = "Enter confirm password"
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.setLeftPaddingPoints(5)
        tf.backgroundColor = .lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signUpButton : UIButton = {
        let btn = UIButton ()
        btn.setTitle("Create Account", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let haveAccountLabel : UILabel = {
        let label = UILabel ()
        label.text = "Have account?"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginButton : UIButton = {
        let btn = UIButton ()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        addSubViewsInSignUp()
        addConstraintsInSignUp()
        self.navigationItem.title = "SignUp"
            
        
        loginButton.addTarget(self, action: #selector(backToLogin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
                                                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        let imgTapGestur = UITapGestureRecognizer(target: self, action: #selector(tapOnImageView))
        
        
        view.addGestureRecognizer(tapGesture)
        signUpImageView.addGestureRecognizer(imgTapGestur)

    }
    
    @objc func createAccount() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if isValidEmail(email) {
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                  
                    guard error == nil else {
                        print("User Created")
                        strongSelf.navigationController?.popToRootViewController(animated: true)
                        return
                    }
                })
                
            } else {
                print("Invalid email")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width:self.view.frame.width, height: screenHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }


    
    @objc func tapOnImageView() {
        print("Tapped on Image")
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func backToLogin() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func addSubViewsInSignUp () {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(signUpImageView)
        scrollView.addSubview(cameraBtn)
        
        scrollView.addSubview(signUpContainerView)
        
        signUpContainerView.addSubview(userNameLabel)
        signUpContainerView.addSubview(userNameTextField)
        
        signUpContainerView.addSubview(emailLabel)
        signUpContainerView.addSubview(emailTextField)
        
        signUpContainerView.addSubview(passwordLabel)
        signUpContainerView.addSubview(passwordTextField)
        
        signUpContainerView.addSubview(confirmPasswordLabel)
        signUpContainerView.addSubview(confirmPasswordTextField)
        
        scrollView.addSubview(signUpButton)
        scrollView.addSubview(haveAccountLabel)
        scrollView.addSubview(loginButton)
        
        //scrollView.addSubview(scrollView)
        
        // btton actions target
        cameraBtn.addTarget(self, action: #selector(cameraPressed), for: .touchUpInside)
        
    }
    
 
    func addConstraintsInSignUp () {
        
        
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        //scrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        //scrollView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        
        signUpImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: screenWidth/2 - screenHeight/10).isActive = true
        signUpImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: screenHeight*0.11).isActive = true
        signUpImageView.heightAnchor.constraint(equalToConstant: screenHeight/5).isActive = true
        signUpImageView.widthAnchor.constraint(equalToConstant: screenHeight/5).isActive = true
        
        
        cameraBtn.bottomAnchor.constraint(equalTo: signUpImageView.bottomAnchor, constant: -20).isActive = true
        cameraBtn.trailingAnchor.constraint(equalTo: signUpImageView.trailingAnchor, constant: 15).isActive = true
        cameraBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cameraBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        signUpContainerView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 16).isActive = true
        signUpContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        signUpContainerView.topAnchor.constraint(equalTo: signUpImageView.bottomAnchor, constant: 0).isActive = true
        signUpContainerView.heightAnchor.constraint(equalToConstant: screenHeight/2.5).isActive = true

        userNameLabel.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        userNameLabel.topAnchor.constraint(equalTo: signUpContainerView.topAnchor, constant: 10).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        userNameTextField.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        userNameTextField.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -10).isActive = true
        userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        userNameTextField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true

        emailLabel.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        emailLabel.topAnchor.constraint(equalTo:userNameTextField.bottomAnchor , constant: 10).isActive = true

        emailTextField.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -10).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
        
        passwordLabel.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        passwordLabel.topAnchor.constraint(equalTo:emailTextField.bottomAnchor , constant: 10).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        passwordTextField.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true
        
        
        confirmPasswordLabel.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        confirmPasswordLabel.topAnchor.constraint(equalTo:passwordTextField.bottomAnchor , constant: 10).isActive = true
        confirmPasswordLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        confirmPasswordTextField.leadingAnchor.constraint(equalTo: signUpContainerView.leadingAnchor, constant: 10).isActive = true
        confirmPasswordTextField.trailingAnchor.constraint(equalTo: signUpContainerView.trailingAnchor, constant: -10).isActive = true
        confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 10).isActive = true
        confirmPasswordTextField.heightAnchor.constraint(equalToConstant: tfHeight).isActive = true

        
        
        signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth/2 - 75).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signUpContainerView.bottomAnchor, constant: 15).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 150).isActive = true

        haveAccountLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth/4).isActive = true
        haveAccountLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        haveAccountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        haveAccountLabel.widthAnchor.constraint(equalToConstant: screenWidth/3-10).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: haveAccountLabel.trailingAnchor, constant: 0).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true

    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
   
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @objc func cameraPressed() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.signUpImageView.image = image
                }
            }

        }
}
