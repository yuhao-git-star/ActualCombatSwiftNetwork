//
//  ViewController.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/7/27.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import UIKit
import PKCHelper
import PromiseKit

class ViewController: UIViewController {
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email 帳號"
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "密碼"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("登入", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor.tiffanyBlue
        bt.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        bt.layer.cornerRadius = 8
        
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .faceBookBlue
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        loginButton.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
    }
    
    @objc fileprivate func handleLogin() {
        PKCLogger.shared.debug(emailTextField.text)
        PKCLogger.shared.debug(passwordTextField.text)
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        _ = AccountsAPIServices.shared.login(email: email, password: password).done { (token) in
            PKCLogger.shared.debug(token)
            }.catch { (error) in
                PKCLogger.shared.error(error.localizedDescription)
                if let authError = error as? AuthError {
                    PKCLogger.shared.error(authError.localizedDescription)
                }
            }.finally {
                // Update UI...
        }
    }
    
}

