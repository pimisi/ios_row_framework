//
//  LoginClient.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/22.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

final class LoginClient: APICientResponseProtocol {
    
    typealias LoginCompletionResult = Result<Login, Failure>
    typealias LoginCompletion = (_ result: LoginCompletionResult) -> Void
    
    private let client: APIClientProtocol
    let baseURL = APIEndpoint.Authentication.Login.base
    
    init(withClient client: APIClientProtocol) {
        self.client = client
        self.client.setBaseURL(withString: baseURL)
    }
    
    func login(username: String, password: String, completion: @escaping LoginCompletion) {
        
        guard !username.isEmpty, !password.isEmpty  else {
            
            let empty: [String] = [username, password].enumerated().compactMap { (index, value) in
                return index == 0 && value.isEmpty ? "Username" :
                    (index == 1 && value.isEmpty ? "Password" : nil)
            }
            
            return completion(.failure(Failure(error: nil, title: "Login Error", message: "\(empty.joined(separator: " and ")) \(empty.count > 1 ? "are" : "is") empty", responseStatusCode: nil)))
        }
        
        let options = APIOption(authorizationType: .basic,
                                authorizationValue: "\(username):\(password)".toBase64())
        
        client.post(data: nil,
                    to: nil,
                    options: options,
                    returnAsData: true) { [weak self] data, error, response in
            self?.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
    }
}
