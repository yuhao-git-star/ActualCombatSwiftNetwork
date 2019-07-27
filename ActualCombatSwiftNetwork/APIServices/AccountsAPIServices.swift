//
//  AccountsAPIServices.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/7/27.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import PKCHelper

class AccountsAPIServices: BaseAPIServices {
    
    static let shared = AccountsAPIServices()
    
    func login(email: String, password: String) -> Promise<String> {
        return Promise<String>.init(resolver: { (resolver) in
            var parameters = [String: AnyObject]()
            
            parameters.updateValue(email as AnyObject, forKey: "email")
            parameters.updateValue(password as AnyObject, forKey: "password")
            
            let req = self.requestGenerator(route: AuthAPIURL.login, parameters: parameters, method: .post, encoding: JSONEncoding.default)
            
            firstly {
                // Get Data
                self.setupResponse(req, type: LoginResult.self)
                }.then { (tokenRes) -> Promise<String> in
                    // setup record token
                    return Promise<String>.init(resolver: { (resolver) in
                        PKCLogger.shared.debug(tokenRes)
                        // Token 處理，解碼與儲存
                        if let token = tokenRes.token {
                            resolver.fulfill(token)
                        } else {
                            resolver.reject(AuthError.tokenIsNotExist)
                        }
                    })
                }.done { (currectUserId) in
                    resolver.fulfill(currectUserId)
                }.catch(policy: .allErrors) { (error) in
                    resolver.resolve(nil, error)
            }
        })
    }
    
    func signup(email: String, password: String, name: String, emailContent: String) -> Promise<String> {
        return Promise<String>.init(resolver: { (resolver) in
            var parameters = [String: AnyObject]()
            
            parameters.updateValue(email as AnyObject, forKey: "email")
            parameters.updateValue(password as AnyObject, forKey: "password")
            parameters.updateValue(name as AnyObject, forKey: "name")
            parameters.updateValue(emailContent as AnyObject, forKey: "emailContent")
            
            let req = self.requestGenerator(route: AuthAPIURL.signup, parameters: parameters, method: .post, encoding: JSONEncoding.default)
            
            firstly {
                // Get Data
                self.setupResponse(req, type: LoginResult.self)
                }.then { (tokenRes) -> Promise<String> in
                    // setup record token
                    return Promise<String>.init(resolver: { (resolver) in
                        PKCLogger.shared.debug(tokenRes)
                        // Token 處理，解碼與儲存
                        if let token = tokenRes.token {
                            resolver.fulfill(token)
                        } else {
                            resolver.reject(AuthError.tokenIsNotExist)
                        }
                    })
                }.done { (currectUserId) in
                    resolver.fulfill(currectUserId)
                }.catch(policy: .allErrors) { (error) in
                    resolver.resolve(nil, error)
            }
        })
    }
}

enum AuthError: Error {
    case tokenIsNotExist
    
    var localizedDescription: String {
        return getLocalizedDescription()
    }
    
    private func getLocalizedDescription() -> String {
        
        switch self {
            
        case .tokenIsNotExist:
            return "token is not find."
        }
        
    }
}
