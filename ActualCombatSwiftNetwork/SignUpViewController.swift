//
//  SignUpViewController.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/7/27.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import UIKit
import PKCHelper
import PromiseKit

class SignUpViewController: UIViewController {
    
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
        tf.textContentType = .newPassword
        
        return tf
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "姓名"
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    lazy var emailContentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "註冊成功 Email, 確認內容"
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    lazy var signupButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.setTitle("註冊", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.backgroundColor = UIColor.arizonaStateUniversityRed
        bt.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        bt.layer.cornerRadius = 8
        
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .aboutMeGreen
        
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nameTextField)
        view.addSubview(emailContentTextField)
        view.addSubview(signupButton)
        
        emailTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 50, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        nameTextField.anchor(top: passwordTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        emailContentTextField.anchor(top: nameTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
        signupButton.anchor(top: emailContentTextField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 50))
    }
    
    @objc fileprivate func handleSignUp() {
        
        // 打印欄位訊息
        PKCLogger.shared.debug(emailTextField.text)
        PKCLogger.shared.debug(passwordTextField.text)
        PKCLogger.shared.debug(nameTextField.text)
        PKCLogger.shared.debug(emailContentTextField.text)
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let name = nameTextField.text,
            let emailContent = emailContentTextField.text else { return }
        
        // 呼叫註冊服務
        _ = AccountsAPIServices.shared.signup(email: email, password: password, name: name, emailContent: emailContent).done { (token) in
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
