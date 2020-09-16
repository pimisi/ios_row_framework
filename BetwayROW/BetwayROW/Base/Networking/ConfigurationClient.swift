//
//  ConfigurationClient.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

class ConfigurationClient: APICientResponseProtocol {
    
    typealias ConfigurationCompletionResult = Result<Configuration, Failure>
    typealias ConfigurationCompletion = (_ result: ConfigurationCompletionResult) -> Void
    
    private let client: APIClientProtocol
    
    var baseURL = APIEndpoint.Configuration.base
    
    init(withClient client: APIClientProtocol) {
        self.client = client
        self.client.setBaseURL(withString: baseURL)
    }
    
    func getChannels(completion: @escaping ConfigurationCompletion) {
        
        guard let regionCode = Application.shared.regionCode else {
            return completion(.failure(Failure(error: nil, title: "Error", message: "The Region Code is not set")))
        }
        
        let path = APIEndpoint.Configuration.channels.appending(regionCode)
        
        client.get(dataFrom: path, urlParams: nil, options: nil, returnAsData: true) { (data, error, response) in
            
            self.processResponse(data: data, error: error, response: response, extectedStatusCode: 200, completion: completion)
        }
        
    }
}
