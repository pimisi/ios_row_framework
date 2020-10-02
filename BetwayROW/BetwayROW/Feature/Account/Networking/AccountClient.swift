//
//  AccountClient.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/10/01.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

class AccountClient: APICientResponseProtocol {
    
    typealias UsernameValidationCompletionResult = Result<UsernameValidation, Failure>
    typealias UsernameValidationCompletion = (_ result: UsernameValidationCompletionResult) -> Void
    
    private let client: APIClientProtocol
    
    var baseURL = APIEndpoint.Account.base
    
    init(withClient client: APIClientProtocol) {
        self.client = client
        self.client.setBaseURL(withString: baseURL)
    }
    
    func validateUsername(_ username: String, completion: @escaping UsernameValidationCompletion) {
        
        let path = APIEndpoint.Account.exists
        
        let options = APIOption(httpHeaders: [APIHeaders.Key.username: username])

        client.get(dataFrom: path, urlParams: nil, options: options, returnAsData: true) { [weak self] data, error, response in
            self?.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
    }
}
